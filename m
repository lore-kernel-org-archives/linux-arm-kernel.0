From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 19 May 2017 15:50:45 -0700
Subject: [PATCH 1/1] ARM: dts: meson: Extend L2 cache controller node for
 Meson8 and Meson8b
In-Reply-To: <20170417214244.23698-2-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Mon, 17 Apr 2017 23:42:44 +0200")
References: <20170417214244.23698-1-martin.blumenstingl@googlemail.com>
 <20170417214244.23698-2-martin.blumenstingl@googlemail.com>
Message-ID: <m2d1b44g1m.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> From: Carlo Caione <carlo@endlessm.com>
>
> This patch extends the L2 cache controller node for the Amlogic Meson8
> and Meson8b SoCs with some missing parameters. These are taken from the
> Amlogic GPL kernel source.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> [apply the change to Meson8 and Meson8b and updated description]
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to v4.13/dt64,

Thanks,

Kevin
