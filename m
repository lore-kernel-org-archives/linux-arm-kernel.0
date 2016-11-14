From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 14 Nov 2016 11:17:19 -0800
Subject: [RFC PATCH] ARM64: dts: Add support for Meson GXM
In-Reply-To: <20161114094411.30199-1-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Mon, 14 Nov 2016 10:44:11 +0100")
References: <20161114094411.30199-1-narmstrong@baylibre.com>
Message-ID: <7hlgwl6fcw.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Following the Amlogic Linux kernel, it seem the only differences
> between the GXL and GXM SoCs are the CPU Clusters.
>
> Simply add a meson-gxm dtsi and reproduce the P23x to Q20x boards
> dts files since the S905D and S912 SoCs shares the same pinout
> and the P23x and Q20x boards are identical.

Since the P23x and Q20x boards are identical, should we just come up
with a singel dtsi for them all? e.g  move the -p23x.dtsi to -pq2xx.dtsi
or something?

I don't think it's a big deal, but it does seem like we should avoid the
copy/paste wherever possible.

Kevin
