From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 23 May 2018 10:07:41 -0700
Subject: [PATCH 0/2] get rid of Kconfig symbol MACH_MESON8B
In-Reply-To: <20180520172353.19256-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 20 May 2018 19:23:51 +0200")
References: <20180520172353.19256-1-martin.blumenstingl@googlemail.com>
Message-ID: <7h603es3ky.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> as noted by Kevin [0] there are two Kconfig symbols which only differ
> in their Kconfig help text and the list of .dtbs that are being built.
> the goal of this small series is to get rid of the unnecessary
> MACH_MESON8B Kconfig symbol by merging it into MACH_MESON8.

Thanks for the cleanup.

Applied to v4.18/dt with Jerome's tag,

Kevin
