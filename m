From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 07 Mar 2018 17:24:43 -0800
Subject: [PATCH] ARM64: dts: meson: reduce odroid-c2 eMMC maximum rate
In-Reply-To: <20180302134436.18844-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Fri, 2 Mar 2018 14:44:36 +0100")
References: <20180302134436.18844-1-jbrunet@baylibre.com>
Message-ID: <7hy3j3fjfo.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Different modules maybe installed by the user on the eMMC connector
> of the odroid-c2. While the red modules are working without an issue,
> it seems some black modules (apparently Samsung based) are having
> issue at 200MHz
>
> While the tuning algorithm introduced in v4.14 enables high speed modes
> on every other tested designs, it seems a problem remains for this
> particular combination of board and eMMC module.
>
> Lowering the maximum frequency of the eMMC on this board until we can
> figure out a better solution.
>
> Fixes: d341ca88eead ("mmc: meson-gx: rework tuning function")
> Suggested-by: Ellie Reeves <ellierevves@gmail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to v4.17/dt64 and Cc'd to stable,

Kevin
