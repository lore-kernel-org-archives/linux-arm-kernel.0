From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 18 Jun 2016 14:07:50 +0200
Subject: [PATCH v2 11/11] arm64: dts: rockchip: Provide emmcclk to PHY for
 rk3399
In-Reply-To: <1465859076-4868-12-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-12-git-send-email-dianders@chromium.org>
Message-ID: <4254489.Jmszz7Rk1t@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 13. Juni 2016, 16:04:35 schrieb Douglas Anderson:
> Previous changes in this series allowed exposing the card clock from the
> rk3399 SDHCI device and allowed consuming the card clock in the rk3399
> eMMC PHY.  Hook things up in the main rk3399 dtsi file.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

as the whole devicetree-part of the emmc addition is in my queue for 4.8, I'll 
pick this patch after everything else has gone into some tree.


Heiko
