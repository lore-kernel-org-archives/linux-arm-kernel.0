From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 22 Jun 2016 18:30:54 +0200
Subject: [PATCH v3 09/15] arm64: dts: rockchip: Add soc-ctl-syscon to
 sdhci for rk3399
In-Reply-To: <1466445414-11974-10-git-send-email-dianders@chromium.org>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-10-git-send-email-dianders@chromium.org>
Message-ID: <8631197.YoqKIsMN0l@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 20. Juni 2016, 10:56:48 schrieb Douglas Anderson:
> On rk3399 we'd like to be able to properly set corecfg registers in the
> Arasan SDHCI component.  Specify the syscon to enable that.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

applied to my dts64-branch for 4.8

Thanks
Heiko
