From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 17 Oct 2017 21:10:23 +0200
Subject: [PATCH 3/9] ARM: dts: rockchip: rk3288-vyasa: Use vmmc-supply
 from PMIC
In-Reply-To: <1508156187-27519-4-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
 <1508156187-27519-4-git-send-email-jagan@amarulasolutions.com>
Message-ID: <3048917.UNI3VLpOcx@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 16. Oktober 2017, 17:46:21 CEST schrieb Jagan Teki:
> rk808, SWITCH_REG1 has configured for sdmmc regulator as vcc_sd,
> so use the same by renaming vcc33_sd to vcc_sd(as per schematic)
> and drop explicit regulator definition from root.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

applied for 4.15
