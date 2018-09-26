From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 26 Sep 2018 10:50:55 +0200
Subject: [PATCH v2 0/5] Meson8b: add support for the Endless Mini EC-100
In-Reply-To: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sat, 22 Sep 2018 17:09:58 +0200")
References: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
Message-ID: <7hd0t063rk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This series adds support for the "Endless Mini" grapefruit-sized mini PC
> from Endless Mobile, Inc. The internal name of this device is EC-100
> (this can be found for example in the GPL kernel tree which is based on
> Amlogic's 3.10 kernel: [0]).
>
> The board is using a Meson8b (S805) SoC with various peripherals.
> The biggest difference compared to boards which are based on Amlogic's
> reference designs is that this board comes with an embedded micro-
> controller called "EC" which makes the system LED pulse during boot
> and allows powering off the board. It also comes with a 10/100 Mbit/s
> Ethernet port and one USB host port.
> There are two variants:
> - 2GB RAM, 32GB storage, 802.11bgn and Bluetooth 4.0
> - 1GB RAM, 24GB storage, neither wifi nor Bluetooth
>
> This series contains support for the new board as well as supporting
> patches for the new vendor prefix and the pin definitions in
> meson8b.dtsi so various peripherals can be enabled.

Applied to v4.20/dt,

Thanks,

Kevin
