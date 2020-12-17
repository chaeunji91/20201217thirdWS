package www.dream.com.framework.dataType;

public class DreamPair<F, S> {
	private F first;
	private S second;
	
	public DreamPair(F first, S second) {
		this.first = first;
		this.second = second;
	}
	
	public F getFirst() {
		return first;
	}
	public S getSecond() {
		return second;
	}
}
