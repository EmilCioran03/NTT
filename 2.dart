int modularExponentiation(int base, int exponent, int mod) {
  int result = 1;
  base = base % mod;
  while (exponent > 0) {
    if (exponent % 2 == 1) result = (result * base) % mod;
    exponent = exponent >> 1;
    base = (base * base) % mod;
  }
  return result;
}


int eulerTotient(int n) {
  int result = n;
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) {
      while (n % i == 0) n ~/= i;
      result -= result ~/ i;
    }
  }
  if (n > 1) result -= result ~/ n;
  return result;
}


int gcdOfArray(List<int> arr) {
  int result = arr[0];
  for (int i = 1; i < arr.length; i++) {
    result = NumberTheoryUtils.gcd(result, arr[i]);
    if (result == 1) return 1;
  }
  return result;
}


int chineseRemainder(List<int> num, List<int> rem) {
  int prod = num.reduce((a, b) => a * b);
  int sum = 0;
  for (int i = 0; i < num.length; i++) {
    int p = prod ~/ num[i];
    sum += rem[i] * modInverse(p, num[i]) * p;
  }
  return sum % prod;
}

int modInverse(int a, int m) {
  int m0 = m, t, q;
  int x0 = 0, x1 = 1;
  if (m == 1) return 0;
  while (a > 1) {
    q = a ~/ m;
    t = m;
    m = a % m;
    a = t;
    t = x0;
    x0 = x1 - q * x0;
    x1 = t;
  }
  if (x1 < 0) x1 += m0;
  return x1;
}


bool isPrimeFermat(int n, int k) {
  if (n <= 1 || n == 4) return false;
  if (n <= 3) return true;
  while (k > 0) {
    int a = 2 + Random().nextInt(n - 4);
    if (NumberTheoryUtils.gcd(n, a) != 1) return false;
    if (modularExponentiation(a, n - 1, n) != 1) return false;
    k--;
  }
  return true;
}



int sumOfDivisors(int n) {
  int sum = 0;
  for (int i = 1; i <= sqrt(n); i++) {
    if (n % i == 0) {
      sum += i;
      if (i != n ~/ i) sum += n ~/ i;
    }
  }
  return sum;
}


bool isPrimeMillerRabin(int n, int k) {
  if (n <= 1 || n == 4) return false;
  if (n <= 3) return true;

  int d = n - 1;
  while (d % 2 == 0) d ~/= 2;

  for (int i = 0; i < k; i++)
    if (!millerTest(d, n)) return false;

  return true;
}

bool millerTest(int d, int n) {
  int a = 2 + Random().nextInt(n - 4);
  int x = modularExponentiation(a, d, n);
  if (x == 1 || x == n - 1) return true;
  while (d != n - 1) {
    x = (x * x) % n;
    d *= 2;
    if (x == 1) return false;
    if (x == n - 1) return true;
  }
  return false;
}




