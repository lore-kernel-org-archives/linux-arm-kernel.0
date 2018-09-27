From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 27 Sep 2018 19:28:37 +0200
Subject: [PATCH] ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees
In-Reply-To: <20180926132339.24737-1-wens@csie.org>
References: <20180926132339.24737-1-wens@csie.org>
Message-ID: <20180927172837.ucxmqfhazt4xwfh2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 09:23:39PM +0800, Chen-Yu Tsai wrote:
> Bananapi released an updated revision of the H3/H5 based Bananapi M2+.
> Version 1.2 enables voltage control for the CPU's regulator by using
> a GPIO line to toggle a MOSFET that can change the effective resistance
> value in the regulator's feedback network.
> 
> This patch adds a common .dtsi file for this new revision, which
> includes the original common sunxi-bananapi-m2-plus.dtsi file, and
> adds the GPIO-controlled regulator and a cpu-supply reference. H3
> and H5 variant dts files are added as well.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
