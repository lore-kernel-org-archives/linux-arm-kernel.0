From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 17 Jul 2018 10:41:35 -0500
Subject: [PATCH 0/6] ARM64: dts: meson-axg: updates
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Mon, 16 Jul 2018 12:11:45 +0200")
References: <20180716101151.31109-1-jbrunet@baylibre.com>
Message-ID: <7hzhypna34.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset groups several updates targeted on amlogic's AXG
> device tree. Patch 1, 2 and 6 had been posted previously but I thought
> it would be more convenient for Kevin to get them as a single series.
>
> Jerome Brunet (6):
>   ARM64: dts: meson-axg: remove vddio_ao18 from SoC dtsi
>   ARM64: dts: meson-axg: add adc buttons the S400
>   ARM64: dts: meson-axg: remove spdif out from gpio a7
>   ARM64: dts: meson-axg: add spdif input pins
>   ARM64: dts: meson-axg: add pdm pins

Applied to v4.19/dt64, queued for the first DT64 pull to arm-soc.

>   ARM64: dts: meson-axg: add the audio clock controller

I'll queue this for a follow-up pull with the dependency tag from the
clock tree.

Kevin
