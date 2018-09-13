From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 12 Sep 2018 21:52:24 -0700
Subject: [PATCH 0/3] arm64: dts: meson-axg: add pdm support
In-Reply-To: <20180831150218.8307-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Fri, 31 Aug 2018 17:02:15 +0200")
References: <20180831150218.8307-1-jbrunet@baylibre.com>
Message-ID: <7hftyevw1j.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds pdm support for amlogic AXG SoC.
> It applies on top of the DT clean-up [0] I sent earlier

Applied to v4.20/dt64.

> The related ASoC PDM patches can be found here [1]. While the ASoC patches
> [2] are obviously needed to for the PDM to work, this series can be safely
> applied without it.

Thanks for the clear explanation of dependencies.

Kevin
