import Foundation
class NewTableViewCell: UITableViewCell {
    
    let width:CGFloat = UIScreen.main.bounds.width
    var loginName:UILabel!      // 名字
    var content:UILabel!  // 出生日期
    var publishTime:UILabel!       // 性别
    var iconImv:UIImageView!    // 头像
    var picture:UIImageView!    //留言图片
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 头像
        iconImv = UIImageView(frame: CGRect(x: 20, y: 15, width: 44, height: 44))
        iconImv.layer.masksToBounds = true
        iconImv.layer.cornerRadius = 22.0
        
        
        picture=UIImageView(frame: CGRect(x: 108, y: 130, width: 192, height: 115))
        
        // 名字
        loginName = UILabel(frame: CGRect(x: 74, y: 15, width: 200, height: 19))
        loginName.textColor = UIColor.black
        loginName.font = UIFont.systemFont(ofSize: 19)
        loginName.textAlignment = .left
        
        // 发表时间
        publishTime = UILabel(frame: CGRect(x: 200, y: 20, width: 200, height: 13))
        publishTime.textColor = UIColor.black
        publishTime.font = UIFont.systemFont(ofSize: 13)
        publishTime.textAlignment = .right
        
        // 发表内容
        content = UILabel(frame: CGRect(x: 74, y: 40, width: width-94, height: 90))
        content.textColor = UIColor.gray
        content.numberOfLines=0
        content.lineBreakMode = NSLineBreakMode.byWordWrapping
        content.textColor = UIColor.black
        content.font = UIFont .systemFont(ofSize: 18)
        content.lineBreakMode = NSLineBreakMode.byTruncatingTail
        content.textAlignment = .left
        
        contentView.addSubview(iconImv)
        contentView.addSubview(loginName)
        contentView.addSubview(publishTime)
        contentView.addSubview(content)
        contentView.addSubview(picture)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

