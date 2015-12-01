From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 01 Dec 2015 19:25:24 +0100
Subject: [PATCH v4] clk: rockchip: switch PLLs to slow mode before reboot
 for rk3288
In-Reply-To: <1448590170-23776-1-git-send-email-zyw@rock-chips.com>
References: <1448590170-23776-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1477792.D13Osl928x@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 27. November 2015, 10:09:30 schrieb Chris Zhong:
> We've been seeing some crashes at reboot test on rk3288-based systems,
> which boards have not reset pin connected to NPOR, they reboot by
> setting 0xfdb9 to RK3288_GLB_SRST_FST register. If the APLL works in
> a high frequency mode, some IPs might hang during soft reset.
> It appears that we can fix the problem by switching to slow mode before
> reboot, just like what we did before suspend.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

applied to my clock branch for 4.5


Thanks
Heiko
