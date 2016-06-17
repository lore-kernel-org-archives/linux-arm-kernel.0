From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 17 Jun 2016 18:45:18 +0530
Subject: [PATCH] phy: rockchip-dp: fix return value check in
 rockchip_dp_phy_probe()
In-Reply-To: <4354296.6MbJoqdM2Z@diego>
References: <1465860707-26005-1-git-send-email-weiyj_lk@163.com>
 <4354296.6MbJoqdM2Z@diego>
Message-ID: <5763F7E6.9090702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 14 June 2016 12:09 PM, Heiko St?bner wrote:
> Am Montag, 13. Juni 2016, 23:31:47 schrieb weiyj_lk at 163.com:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> In case of error, the function devm_kzalloc() returns NULL pointer
>> not ERR_PTR(). The IS_ERR() test in the return value check should
>> be replaced with NULL test.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> obviously correct, thanks for catching.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

applied, thanks.

-Kishon
