From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 08 Dec 2016 20:39:03 -0800
Subject: [PATCH v2 0/2] GXL and GXM SCPI improvements
In-Reply-To: <20161202230849.11422-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sat, 3 Dec 2016 00:08:47 +0100")
References: <20161123162040.24843-1-martin.blumenstingl@googlemail.com>
 <20161202230849.11422-1-martin.blumenstingl@googlemail.com>
Message-ID: <m2d1h1btso.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This series adds SCPI support to GXL and GXM SoCs by moving the nodes
> to meson-gx.dtsi.
> Now that we have SCPI support for GXM we can also use it to configure
> the CPU cores using the SCPI DVFS clocks.
>
> Changes since v1:
> - added Tested-By and Acked-By tags from Neil Armstrong (thanks!)
> - rebased to khilman/linux-amlogic.git/amlogic-dt64-2-v2
> - updated description of patch 1 because the "arm,scpi-pre-1.0" change
>   is already part of the amlogic-dt64-2-v2 tag

Thanks for the respin.  It's now too late for v4.10 (I freeze things
around -rc6 or -rc7, and it's now -rc8), but I'll queue this up for
v4.11.

Thanks,

Kevin
