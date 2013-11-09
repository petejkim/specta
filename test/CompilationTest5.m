#import "TestHelper.h"

static int
  beforeEachRan
, beforeEach2Ran
, example1RanCorrectly
, example2RanCorrectly
, afterEachRan
, afterEach2Ran
;

SpecBegin(_CompilationTest5)

describe(@"group", ^{
  beforeEach(^{
    beforeEachRan ++;
  });

  beforeEach(^{
    beforeEach2Ran ++;
  });

  it(@"example 1", ^{
    if (beforeEachRan == 1 && beforeEach2Ran == 1 &&
       afterEachRan == 0 && afterEach2Ran == 0) {
      example1RanCorrectly ++;
    }
  });

  it(@"example 2", ^{
    if (beforeEachRan == 2 && beforeEach2Ran == 2 &&
       afterEachRan == 1 && afterEach2Ran == 1) {
      example2RanCorrectly ++;
    }
  });

  afterEach(^{
    afterEachRan ++;
  });

  afterEach(^{
    afterEach2Ran ++;
  });
});

SpecEnd

@interface CompilationTest5 : XCTestCase; @end
@implementation CompilationTest5

- (void)testMultipleBeforeEachAndAfterEachHooks {
  beforeEachRan = afterEachRan = beforeEach2Ran = afterEach2Ran = example1RanCorrectly = example2RanCorrectly = 0;

  RunSpec(_CompilationTest5Spec);

  SPTAssertEqual(example1RanCorrectly, 1);
  SPTAssertEqual(example2RanCorrectly, 1);

  SPTAssertEqual(beforeEachRan, 2);
  SPTAssertEqual(beforeEach2Ran, 2);
  SPTAssertEqual(afterEachRan, 2);
  SPTAssertEqual(afterEach2Ran, 2);
}

@end
