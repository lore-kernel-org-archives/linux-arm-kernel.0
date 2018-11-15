From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 15 Nov 2018 12:16:35 -0800
Subject: [PATCH] ARM64: dts: meson: p230: disable advertisement EEE for
 GbE.
In-Reply-To: <20181109125936.3siduqtjmj6vv5ur@raspberrypi>
References: <20181109125936.3siduqtjmj6vv5ur@raspberrypi>
Message-ID: <7hh8gidrks.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

He Yangxuan <yangxuan8282@gmail.com> writes:

> This patch disable EEE advertisement for P230 board (DWMAC + RTL8211F).
> If not disable it, the network connection is not stable, will got issues
> like throughput drop or broken link.
>
> Signed-off-by: He Yangxuan <yangxuan8282@gmail.com>

Thanks for the patch.

Queued for v4.21 (branch: v4.21/dt64)

Kevin
