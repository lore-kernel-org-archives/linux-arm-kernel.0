From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Mar 2016 12:13:49 +0100
Subject: [PATCH v4 3/4] clk: rockchip: add new pll-type for rk3399 and
 similar socs
In-Reply-To: <1457581622-31192-4-git-send-email-zhengxing@rock-chips.com>
References: <1457581622-31192-1-git-send-email-zhengxing@rock-chips.com>
 <1457581622-31192-4-git-send-email-zhengxing@rock-chips.com>
Message-ID: <2534564.6HRxTH61cO@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 10. M?rz 2016, 11:47:01 schrieb Xing Zheng:
> The rk3399's pll and clock are similar with rk3036's, it different
> with base on the rk3066(rk3188, rk3288, rk3368 use it), there are
> different adjust foctors and control registers, so these should be
> independent and separate from the series of rk3066s.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied to my clk-branch for 4.7


Thanks
Heiko
