From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 03 Apr 2017 09:08:45 -0700
Subject: [PATCH v2 2/2] pinctrl: meson: meson8b: rename the NAND DQS pin
 definitions
In-Reply-To: <20170401135922.1288-3-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sat, 1 Apr 2017 15:59:22 +0200")
References: <20170325184350.7677-1-martin.blumenstingl@googlemail.com>
 <20170401135922.1288-1-martin.blumenstingl@googlemail.com>
 <20170401135922.1288-3-martin.blumenstingl@googlemail.com>
Message-ID: <m28tnha2ya.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The NAND DQS pins are currently named nand_dqs_0 and nand_dqs_1.
> However, they both seem to have the same function, just exposed on
> different pins (unlike the ethernet TX pins for example, where there's
> eth_txd0..3 - all of these can be active at the same time as they are
> different data lines).
> Rename the NAND DQS pins to nand_dqs_15 and nand_dqs_18 to reflect that
> it's the same functionality just exposed on different pins (BOOT_15 and
> BOOT_18).
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Since we don't yet have any users of these pins, LGTM.

Acked-by: Kevin Hilman <khilman@baylibre.com>
