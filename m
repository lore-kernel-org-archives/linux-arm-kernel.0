From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 09 Oct 2018 10:29:56 +0200
Subject: [PATCH 0/2] arm64: dts: meson: s400: emmc updates
In-Reply-To: <20181002084341.5487-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Tue, 2 Oct 2018 10:43:39 +0200")
References: <20181002084341.5487-1-jbrunet@baylibre.com>
Message-ID: <7hbm834j5n.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds the emmc pwrseq to the emmc node and disable the device
> by default, since eMMC is not the default option for this board.
>
> Jerome Brunet (2):
>   arm64: dts: meson-axg: s400: add missing emmc pwrseq
>   arm64: dts: meson-axg: s400: disable emmc

Appled to v4.20/dt64.

Thanks.

Kevin

P.S.  Looks like I forgot to reply when I applied these, but these are
      already submitted to arm-soc and merged.
