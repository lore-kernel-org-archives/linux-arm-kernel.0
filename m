From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 06 Dec 2017 11:44:48 -0800
Subject: [PATCH 0/2] update the L2 cache settings on Meson8/Meson8b
In-Reply-To: <20171031222316.24548-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Tue, 31 Oct 2017 23:23:14 +0100")
References: <20171031222316.24548-1-martin.blumenstingl@googlemail.com>
Message-ID: <7ha7yvsksv.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The L2 cache settings on our mainline kernel did not match the
> configuration from Amlogic's vendor kernel.
>
> This was boot-tested on a Meson8 (actually Meson8m2, but both use
> the same CPU cores and L2 cache configuration) and a Meson8b board.

Boot tested on meson8b-odroidc1, and applied to v4.16/dt,

Thanks,

Kevin
