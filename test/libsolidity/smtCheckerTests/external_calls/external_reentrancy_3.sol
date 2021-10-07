abstract contract D {
	function d() virtual public {}
}

contract A {
	int x = 0;

	function f() virtual public view {
		assert(x == 0); // should hold
		assert(x == 1); // should fail
	}
}
contract C is A {
	constructor() {
		x = 1;
	}

	function call(D d) public {
		d.d();
	}

	function f() public view override {
		assert(x == 1); // should hold
		//Disabled because of Spacer nondeterminism.
		//assert(x == 0); // should fail
	}
}
// ====
// SMTEngine: all
// SMTIgnoreCex: yes
// SMTIgnoreInv: yes
// SMTIgnoreOS: macos
// ----
// Info 1180: Contract invariant(s) for :C:\n(!(x >= 2) && !(x <= 0))\nContract invariant(s) for :A:\n((x >= 0) && (x <= 0))\nReentrancy property(ies) for :C:\n((!(x' <= 0) || (x <= 0)) && (!(x <= 1) || !(x' >= 2)) && (!(x = 1) || !(<errorCode> >= 7)))\n((!(x' <= 0) || (x <= 0)) && (!(x <= 1) || !(x' >= 2)))\n
