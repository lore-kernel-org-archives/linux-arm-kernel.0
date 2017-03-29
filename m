From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 29 Mar 2017 13:21:11 -0700
Subject: [PATCH v2,1/3] meson_uart: expose CLKID_UARTx
In-Reply-To: <CAFBinCDF29+kQpedsJPqRy6fztWrj91Qi6tCno_2S6UCkhW7XQ@mail.gmail.com>
 (Martin Blumenstingl's message of "Tue, 28 Mar 2017 23:24:15 +0200")
References: <20170328092545.4644-1-hgkr.klein@gmail.com>
 <20170328092545.4644-2-hgkr.klein@gmail.com>
 <1490716277.20764.6.camel@baylibre.com>
 <71489b62-78c8-7082-587e-8598dc43ca59@gmail.com>
 <1490728490.20764.8.camel@baylibre.com>
 <CAFBinCDF29+kQpedsJPqRy6fztWrj91Qi6tCno_2S6UCkhW7XQ@mail.gmail.com>
Message-ID: <m2y3vn6dhk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

[...]

> for Helmut this would mean that instead of dropping this patch (or
> dropping CLKID_UART1 and CLKID_UART2 from this patch) he would rather
> have to *add* another patch (for meson-gxbb.dtsi and meson-gxl.dtsi)
> which passes the core clocks to the corresponding UART controllers
> (similar to the CLKID_SD_EMMC_ clocks).

Yes, this is what I would like to see.

If a new CLKID is exposed, I want to see the users of it at the same
time.

Kevin
