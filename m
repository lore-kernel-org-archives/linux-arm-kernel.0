From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 31 Jul 2018 14:34:52 +0200
Subject: [PATCH v6 0/4] IR support for A83T
In-Reply-To: <20180731092258.2279-1-embed3d@gmail.com>
References: <20180731092258.2279-1-embed3d@gmail.com>
Message-ID: <20180731123452.74jyxc4q3ewig35z@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 11:22:54AM +0200, Philipp Rossak wrote:
> This patch series adds support for the sunxi A83T ir module and enhances 
> the sunxi-ir driver. Right now the base clock frequency for the ir driver
> is a hard coded define and is set to 8 MHz.
> This works for the most common ir receivers. On the Sinovoip Bananapi M3 
> the ir receiver needs, a 3 MHz base clock frequency to work without
> problems with this driver.
> 
> This patch series adds support for an optinal property that makes it able
> to override the default base clock frequency and enables the ir interface 
> on the a83t and the Bananapi M3.

Once the minor comment on patch 2 has been fixed,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
