From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 22 Mar 2017 09:17:27 -0700
Subject: [PATCH 0/3] Khadas VIM support (Amlogic Meson GXL S905X)
In-Reply-To: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sat, 4 Mar 2017 22:51:23 +0100")
References: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
Message-ID: <m2zigdmgko.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This series adds support for the Khadas VIM and Khadas VIM Pro boards
> (both are provided through a single .dts as the only two differences are
> the eMMC size and different SDIO WIFI chips - both are Broadcom brcmfmac
> based though).
> More details can be found on the official website: [0]
>
> I have tested this on a Khadas VIM Pro board. It would be nice if someone
> with a non-Pro board could give it a try as well.

Applied to v4.12/dt64

After all the discussion, I left patch 1 as is.

Kevin
