From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 17 Feb 2016 22:00:17 +0100
Subject: [PATCH v8.1 1/2] drm/rockchip: hdmi: add Innosilicon HDMI support
In-Reply-To: <1454492697-7837-1-git-send-email-ykk@rock-chips.com>
References: <1454049768-30872-1-git-send-email-ykk@rock-chips.com>
 <1454492697-7837-1-git-send-email-ykk@rock-chips.com>
Message-ID: <3883951.Go5JsyhPRt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 3. Februar 2016, 17:44:57 schrieb Yakir Yang:
> The Innosilicon HDMI is a low power HDMI 1.4 transmitter
> IP, and it have been integrated on some rockchip CPUs
> (like RK3036, RK312x).
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

On a Kylin board against 4.5-rc
Tested-by: Heiko Stuebner <heiko@sntech.de>

@Mark: While testing I noticed a black box around my cursor. It moves with 
the cursor, so seems to be the plane itself - the hdmi driver is of course 
innocent. May there exist an issue with plane transparency?


Heiko
