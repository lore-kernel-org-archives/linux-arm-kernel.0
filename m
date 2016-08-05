From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 05 Aug 2016 16:46:17 -0700
Subject: [PATCH v4 3/3] ARM: davinci_all_defconfig: enable SMSC ethernet
 PHY
In-Reply-To: <20160805202951.2848-4-kbeldan@baylibre.com> (Karl Beldan's
 message of "Fri, 5 Aug 2016 20:29:51 +0000")
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <20160805202951.2848-1-kbeldan@baylibre.com>
 <20160805202951.2848-4-kbeldan@baylibre.com>
Message-ID: <m2a8gqkcdy.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Karl Beldan <kbeldan@baylibre.com> writes:

> The LCDK embeds a LAN8710.
>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Tested on da850-lcdk with an NFS root filesystem.

Kevin
