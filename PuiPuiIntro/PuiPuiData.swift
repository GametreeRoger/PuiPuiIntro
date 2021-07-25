//
//  PuiPuiData.swift
//  PuiPuiData
//
//  Created by 張又壬 on 2021/7/25.
//

import UIKit

struct PuiPuiData {
    var pictureName: String
    var name: String
    var intro: String
    var picture: UIImage? {
        UIImage(named: pictureName)
    }
}

extension PuiPuiData {
    static var data: [PuiPuiData] {
        [
            PuiPuiData(pictureName: "chara01.jpeg", name: "馬鈴薯", intro: "個性悠哉，但也有無視司機駕駛的一面。若是出現需要幫助的人，有著無論甚麼狀況都會挺身而出的勇氣。喜歡紅蘿蔔。"),
            PuiPuiData(pictureName: "chara02.jpeg", name: "西羅摩", intro: "具有比一般天竺鼠還膽小的性格。會向溫柔的駕駛撒嬌，常被捲入各種麻煩之中。仰慕如同姐姐一般的泰迪。喜歡生菜。"),
            PuiPuiData(pictureName: "chara03.jpeg", name: "阿比", intro: "認真且好奇心旺盛。標註著新手記號，夢想著有朝一日能畢業。有著比其他的天竺鼠還要高的自尊心。害怕貓咪。"),
            PuiPuiData(pictureName: "chara04.jpeg", name: "巧克力", intro: "爽朗又賢淑、卻有著意想不到的強而有力的體能。喜歡打扮也重視時尚。夢想是成為No.1的高級天竺鼠車車。"),
            PuiPuiData(pictureName: "chara05.jpeg", name: "泰迪", intro: "總之就是什麼都吃、什麼都不怕的活潑女孩兒。總有驚人之舉的麻煩製造車，讓大夥兒相當頭疼。")
        ]
    }
}
