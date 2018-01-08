From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 08 Jan 2018 09:54:54 +0100
Subject: [PATCH v2 1/5] ARM64: dts: meson: uart: fix address space range
In-Reply-To: <20180106001044.108163-2-yixun.lan@amlogic.com>
References: <20180106001044.108163-1-yixun.lan@amlogic.com>
 <20180106001044.108163-2-yixun.lan@amlogic.com>
Message-ID: <1515401694.5048.69.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-01-06 at 08:10 +0800, Yixun Lan wrote:
> The address space range is actually 0x18, fixed here.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi |  4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
