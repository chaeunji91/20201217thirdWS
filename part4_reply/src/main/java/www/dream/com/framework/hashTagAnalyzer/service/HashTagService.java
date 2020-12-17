package www.dream.com.framework.hashTagAnalyzer.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import kr.co.shineware.util.common.model.Pair;
import www.dream.com.framework.dataType.DreamPair;
import www.dream.com.framework.hashTagAnalyzer.model.HashTagVO;
import www.dream.com.framework.hashTagAnalyzer.model.mapper.HashTagMapper;

@Service
/*
 * 컨텍스트에서 빈을 만드는 기본은 Singleton(단 한개 - Service, Control Bean은 처리 객체다.)
 * 다중 처리 등으로 여러 객체을 만들 필요가 있다면 @Scope("prototype")을 적용해 놓고
 */
@Scope("prototype")
public class HashTagService {
	private static Komoran komoran = new Komoran(DEFAULT_MODEL.FULL);
	
	@Autowired
	private HashTagMapper hashTagMapper;
	
	private static Set<String> setTargetLexiconType = new TreeSet<>();
	static {
		setTargetLexiconType.add("SL");
		setTargetLexiconType.add("NA");
		setTargetLexiconType.add("NNG");
		setTargetLexiconType.add("NNP");
	}

	public Set<String> extractHashTag(String... varText) {
		Set<String> ret = new TreeSet<>();

		for (String text : varText) {
			KomoranResult komoranResult = komoran.analyze(text);
			List<Pair<String, String>> sentence = komoranResult.getList();
			for (Pair<String, String> token : sentence) {
				if (setTargetLexiconType.contains(token.getSecond()))
					ret.add(token.getFirst());
			}
		}
		return ret;
	}

	/**
	 * 
	 * @param arrHashTag
	 * @return first : 있는 것. 즉 교집합, second : 새로운 단어
	 */
	public DreamPair<List<HashTagVO>, List<HashTagVO>> split(String[] arrHashTag) {
		/* 아래와 동일한 기능을 고전적 살못된 방식으로 개발한 사례
		List<HashTagVO> listExistingㅇㅇㅇㅇ = hashTagMapper.findExisting(arrHashTag);
		List<HashTagVO> listNewTag = new ArrayList<>();
		O :
		for (String aWord : arrHashTag) {
			for (HashTagVO e : listExistingㅇㅇㅇㅇ) {
				if (e.getWord().equals(aWord)) {
					continue O;
				}
			}
			HashTagVO ddd = new HashTagVO();
			ddd.setWord(aWord);
			listNewTag.add(ddd);
		}
		*/
		
		//배열에서 주어진 단어를 바탕으로 전체 단어 객체를 만들었음
		List<HashTagVO> listFullTag = new ArrayList<>();
		for (String aWord : arrHashTag) {
			if (aWord.isEmpty())
				continue;
			HashTagVO ht = new HashTagVO();
			ht.setWord(aWord);
			listFullTag.add(ht);
		}
		//기존 테이블에서 관리 중인 단어 객체를 찾음
		List<HashTagVO> listExisting = hashTagMapper.findExisting(arrHashTag);
		//HashTagVO.equals 기능을 word를 바탕으로 만들어서 일괄 삭제함.
		//따라서 새로이 나타난 단어들을 찾음
		listFullTag.removeAll(listExisting);
		
		return new DreamPair<>(listExisting, listFullTag);
	}

	@Transactional
	public void createHashTag(List<HashTagVO> listHashTag) {
		long newId = hashTagMapper.selectNewID();
		for (HashTagVO obj : listHashTag)
			obj.setId(newId++);
		if (!listHashTag.isEmpty()) 
			hashTagMapper.createHashTag(listHashTag);
	}

	public void createRelWithReply(long replyId, List<HashTagVO> listHashTag) {
		if (!listHashTag.isEmpty()) 
			hashTagMapper.createRelWithReply(replyId, listHashTag);
	}

	public void deleteRelWithReply(long replyId) {
		hashTagMapper.deleteRelWithReply(replyId);
	}
}
