From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 24 Aug 2017 17:05:18 -0700
Subject: [PATCH v2 15/16] mmc: meson-gx: change default tx phase
In-Reply-To: <20170821160301.21899-16-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Mon, 21 Aug 2017 18:03:00 +0200")
References: <20170821160301.21899-1-jbrunet@baylibre.com>
 <20170821160301.21899-16-jbrunet@baylibre.com>
Message-ID: <7h8ti8h5q9.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Initial default tx phase was set to 0 while the datasheet recommends 270.
> Some cards fails to initialize with this setting and eMMC mode DDR52 does
> not work.
>
> Changing this setting to 270 fixes these issues, without any regression
> so far
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
