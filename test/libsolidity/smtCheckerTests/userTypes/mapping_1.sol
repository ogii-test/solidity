type MyInt is int;
contract C {
    mapping(MyInt => int) m;
	function f(MyInt a) public view {
		assert(m[a] == 0); // should hold
		assert(m[a] != 0); // should fail
	}
}
// ====
// SMTEngine: all
// SMTIgnoreInv: yes
// ----
// Info 1180: Contract invariant(s) for :C:\n(true && true)\n
