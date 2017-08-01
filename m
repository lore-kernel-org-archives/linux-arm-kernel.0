From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 01 Aug 2017 12:48:48 -0700
Subject: [PATCH] ARM64: dts: meson-gx: Use correct mmc clock source 0
In-Reply-To: <20170731120552.31606-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Mon, 31 Jul 2017 14:05:52 +0200")
References: <20170731120552.31606-1-jbrunet@baylibre.com>
Message-ID: <7h60e7yspr.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Now that the clock source 0 is properly described in the CCF, use it
> instead of assuming the default value (xtal)
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>
> This patchset depends on clock patchset adding the related clocks:
> * https://lkml.kernel.org/r/20170731115603.29720-1-jbrunet at baylibre.com

I'll need a stable tag/commit in clk-meson/next/drivers to use in order
to apply this one.

Kevin
