From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Mar 2017 17:47:41 +0100
Subject: [PATCH] ARM: dts: rockchip: increase SD clock frequency on Radxa
 Rock
In-Reply-To: <1490110822-3310-1-git-send-email-al.kochet@gmail.com>
References: <1490110822-3310-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1978752.xjtBqdMt97@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, 21. M?rz 2017, 18:40:22 CET schrieb Alexander Kochetkov:
> The patch set SD clock frequency to maximum possible to SD-card
> (50MHz). This change actual clock frequency from 32MHz to 48MHz
> (speedup 1.5X).
> 
> Banner line before patch: 'mmc_host mmc0: Bus speed (slot 0) = 32000000Hz
> (slot req 50000000Hz, actual 32000000HZ div = 0)'.
> Banner line after patch: 'mmc_host mmc0: Bus speed (slot 0) = 96000000Hz
> (slot req 50000000Hz, actual 48000000HZ div = 1)'
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

sorry, but I will not apply this patch at this time.

When testing on my radxarock with the card I always use upon entering the 
rootfs everything explodes with -110 errors, while without that patch the card 
runs stable as far as I can tell.

I also don't have the time to investigate further right now though.


Heiko
