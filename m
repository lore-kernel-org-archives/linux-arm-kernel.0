From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 18 Aug 2016 07:47:39 -0500
Subject: [PATCH v2] ARM: dts: da850-lcdk: Audio support via simple-card
In-Reply-To: <20160817125454.20717-1-kbeldan@baylibre.com> (Karl Beldan's
 message of "Wed, 17 Aug 2016 12:54:54 +0000")
References: <20160817125454.20717-1-kbeldan@baylibre.com>
Message-ID: <m2vayy6y6s.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Karl Beldan <kbeldan@baylibre.com> writes:

> The LCDK embeds a TLV320AIC3106 connected to the SoC McASP for analog
> audio. The power supply of the codec comes from the main PMIC
> (TPS650250) DCDCs which are always on per HW design and not
> controllable by SW, so SW wise the codec driver will rely on the 'dummy'
> regulator.
> Quality is good with arecord -pipe- aplay on Line In/Line Out.
>
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>

Tested pass through: "arecord -f cd | aplay -" on DA850-LCDK.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
