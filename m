From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 28 Mar 2017 12:33:53 -0700
Subject: [PATCH v2 0/8] pinctrl: meson: add audio output pins
In-Reply-To: <20170326171923.19269-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Sun, 26 Mar 2017 19:19:15 +0200")
References: <20170326171923.19269-1-jbrunet@baylibre.com>
Message-ID: <m2inmt9owu.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds the pinctrl definition and the related device-tree
> bindings of the i2s output and spdif output pins on the meson gxbb and
> gxl SoCs.
>
> This is part of the ongoing work to bring audio output support on the
> meson family. It was tested on the gxbb p200 and gxl p230.
>
> Changes since v1: [0]
> * add a few comments in the changelog
> * patched rebased on pinctrl/for-next + Neil patch on missing pins [1]
>
> [0]: https://marc.info/?i=20170323165101.29262-1-jbrunet%40baylibre.com
> [1]: https://marc.info/?i=20170323104112.16558-2-narmstrong%40baylibre.com
>
> Jerome Brunet (8):
>   pinctrl: meson: gxbb: add i2s output pins
>   pinctrl: meson: gxbb: add spdif output pins
>   pinctrl: meson: gxl: add i2s output pins
>   pinctrl: meson: gxl: add spdif output pins
>   ARM64: dts: meson-gxbb: add i2s output pins
>   ARM64: dts: meson-gxbb: add spdif output pins
>   ARM64: dts: meson-gxl: add i2s output pins
>   ARM64: dts: meson-gxl: add spdif output pins

DT patches applied to amlogic v4.12/dt64 branch,

Thanks for the respin,

Kevin
