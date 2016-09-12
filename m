From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 12 Sep 2016 11:07:46 -0700
Subject: [PATCH v2 1/2] pinctrl: meson-gxbb: add the missing SDIO
 interrupt pin
In-Reply-To: <20160911123903.20027-2-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 11 Sep 2016 14:39:02 +0200")
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
 <20160911123903.20027-1-martin.blumenstingl@googlemail.com>
 <20160911123903.20027-2-martin.blumenstingl@googlemail.com>
Message-ID: <7hr38poutp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This adds the SDIO interrupt pin which can be used by sd_emmc_a.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Fixes: 29885a656511 ("pinctrl: meson-gxbb: add the pins for the
> SDIO/sd_emmc_a controller")

Acked-by: Kevin Hilman <khilman@baylibre.com>
