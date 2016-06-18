From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 18 Jun 2016 14:49:24 +0200
Subject: [PATCH v2 05/11] arm64: dts: rockchip: Add soc-ctl-syscon to
 sdhci for rk3399
In-Reply-To: <1465859076-4868-6-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-6-git-send-email-dianders@chromium.org>
Message-ID: <8241867.c5NxmDgk2P@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 13. Juni 2016, 16:04:29 schrieb Douglas Anderson:
> On rk3399 we'd like to be able to properly set corecfg registers in the
> Arasan SDHCI component.  Specify the syscon to enable that.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

as the whole devicetree-part of the emmc addition is in my queue for 4.8, I'll 
pick this patch after everything else has gone into some tree.


Heiko
