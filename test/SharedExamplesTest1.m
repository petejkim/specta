#import "TestHelper.h"

static NSMutableArray *items;

SpecBegin(_SharedExamplesTest1)

sharedExamplesFor(@"shared1", ^(NSDictionary *data) {
  describe(@"foo", ^{
    it(@"equals string 'Foo'", ^{
      expect([data objectForKey:@"foo"]).toEqual(@"Foo");
    });
  });

  describe(@"bar", ^{
    it(@"equals string 'Bar'", ^{
      expect([data objectForKey:@"bar"]).toEqual(@"Bar");
    });
  });
});

sharedExamples(@"shared2", ^(NSDictionary *data) {
  it(@"inserts data.baz to items", ^{
    [items addObject:data[@"baz"]];
  });
});

describe(@"group", ^{
  itShouldBehaveLike(@"shared1",
                     @{@"foo" : @"Foo",
                       @"bar" : @"Bar"});
});

itBehavesLike(@"shared2", @{@"baz": @"hello"});

context(@"group2", ^{
  itBehavesLike(@"shared2", @{@"baz": @"world"});
});

SpecEnd

@interface SharedExamplesTest1 : SenTestCase; @end
@implementation SharedExamplesTest1

- (void)testSharedExamples {
  items = [[NSMutableArray alloc] init];
  SenTestSuiteRun *result = RunSpec(_SharedExamplesTest1Spec);
  expect([result testCaseCount]).toEqual(4);
  expect([result failureCount]).toEqual(0);
  expect([result hasSucceeded]).toEqual(YES);
  expect(items).toEqual((@[ @"hello", @"world" ]));
  items = nil;
}

@end
