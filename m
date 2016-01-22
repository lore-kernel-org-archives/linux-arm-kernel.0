From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 22 Jan 2016 14:33:13 +0100
Subject: [PATCH] ARM: dts: rockchip: Bump sd card pin drive strength up on
 firefly boards
In-Reply-To: <1453381033-3479-1-git-send-email-w.egorov@phytec.de>
References: <1453381033-3479-1-git-send-email-w.egorov@phytec.de>
Message-ID: <1922254.O59ZZAW3Pv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 21. Januar 2016, 13:57:13 schrieb Wadim Egorov:
> It seems some firefly boards need 12mA drive strength for sdmmc.
> Using 4mA/8mA drive strength will cause the kernel to fail to recognize
> the sd card correctly.
> Increased the sdmmc lines drive strength from 4mA to 12mA.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

applied to my dts32 branch for 4.6.

As I said somewhere on IRC before, it might be worthwhile to bump the 
default drive-strength at some point, but so far it seems the minimal needed 
values seem to diverge (8mA on Veyron, 12ma [4mA on mine] on firefly and 
seemingly 4mA working fine on the Rock2). So I guess we'll postpone that a 
bit more until we have more datapoints ;-)


Heiko
