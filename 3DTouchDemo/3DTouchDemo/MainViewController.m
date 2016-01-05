//
//  ViewController.m
//  3DTouchDemo
//
//  Created by App on 1/4/16.
//  Copyright © 2016 App. All rights reserved.
//

#import "MainViewController.h"
#import "PreviewViewController.h"

@interface MainViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) NSArray *cellArr;
@property (nonatomic, strong) PreviewViewController *vc;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _cellArr = @[@"1", @"2", @"3"];
}

-(PreviewViewController *)vc{
    if(!_vc){
        _vc = [[PreviewViewController alloc] initWithTitle:@"abc"];
        [_vc.view setBackgroundColor:[UIColor redColor]];
    }
    return _vc;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdenfitier = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfitier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenfitier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = _cellArr[indexPath.row];
    [self registerForPreviewingWithDelegate:self sourceView:cell];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row - %d", indexPath.row);
}

//重按时显示出的预览界面
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    
    //添加个导航栏显示预览界面
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.vc];
//    return nav;
    
    //直接显示预览界面
    return self.vc;
}
//继续用力按执行什么操作，这里是将预览界面展示出来
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [self showViewController:self.vc sender:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
