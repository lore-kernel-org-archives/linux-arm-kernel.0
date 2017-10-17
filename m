From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 17 Oct 2017 21:07:14 +0200
Subject: [PATCH 1/9] ARM: dts: rockchip: rk3288-vyasa: Remove vdd_log from
 rk808, DCDC_REG1
In-Reply-To: <1508156187-27519-2-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
 <1508156187-27519-2-git-send-email-jagan@amarulasolutions.com>
Message-ID: <3424934.UivI2BNsfM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 16. Oktober 2017, 17:46:19 CEST schrieb Jagan Teki:
> vdd_log, never used on DCDC_REG1 of rk808 from latest schematic so
> remove the same and update the regulator-name as 'vdd_arm' to sync
> with existing rk3288 board dts files.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

applied for 4.15
