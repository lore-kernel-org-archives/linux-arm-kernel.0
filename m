From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 19 Apr 2018 10:58:52 -0700
Subject: [PATCH v2] ARM64: dts: meson-axg: enable the eMMC controller
In-Reply-To: <20180408113647.13543-1-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Sun, 8 Apr 2018 11:36:47 +0000")
References: <20180408113647.13543-1-yixun.lan@amlogic.com>
Message-ID: <7ho9if3wo3.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> From: Nan Li <nan.li@amlogic.com>
>
> The IP of eMMC controller in AXG is similiar to Meson-GX series.
> Here we add the initial support of the HS200 mode with
> clock running at 166MHz (to be safe), since we found some eMMC chip
> fail to run at 200MHz due to tunning phase error.
>
> Signed-off-by: Nan Li <nan.li@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Applied to v4.18/dt64

> ---
> Hi Kevin
>   Please note this patch actually depend on the eMMC driver here [0].
>   Still a few problem to solve, to improve the tuning phase driver to make
> the clock running at 200MHz, and to further support the HS400 mode.
> Anyway, this patch itself is quite independent.

The driver changes are queued for v4.18 also.  Good!

Kevin
