From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 14 Jun 2016 08:39:57 +0200
Subject: [PATCH] phy: rockchip-dp: fix return value check in
 rockchip_dp_phy_probe()
In-Reply-To: <1465860707-26005-1-git-send-email-weiyj_lk@163.com>
References: <1465860707-26005-1-git-send-email-weiyj_lk@163.com>
Message-ID: <4354296.6MbJoqdM2Z@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 13. Juni 2016, 23:31:47 schrieb weiyj_lk at 163.com:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_kzalloc() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

obviously correct, thanks for catching.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
