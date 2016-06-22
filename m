From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 22 Jun 2016 18:31:09 +0200
Subject: [PATCH v3 15/15] arm64: dts: rockchip: Provide emmcclk to PHY for
 rk3399
In-Reply-To: <1466445414-11974-16-git-send-email-dianders@chromium.org>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-16-git-send-email-dianders@chromium.org>
Message-ID: <2700041.i9WYqvILHH@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 20. Juni 2016, 10:56:54 schrieb Douglas Anderson:
> Previous changes in this series allowed exposing the card clock from the
> rk3399 SDHCI device and allowed consuming the card clock in the rk3399
> eMMC PHY.  Hook things up in the main rk3399 dtsi file.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

applied to my dts64-branch for 4.8

Thanks
Heiko
