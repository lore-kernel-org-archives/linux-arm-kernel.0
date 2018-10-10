From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 10 Oct 2018 16:59:37 +0200
Subject: [PATCH 3/4] ARM: dts: sun7i: Add pinmux configuration for LCD0
 RGB888 pins
In-Reply-To: <20181010114134.8211-3-contact@paulk.fr>
References: <20181010114134.8211-1-contact@paulk.fr>
 <20181010114134.8211-3-contact@paulk.fr>
Message-ID: <20181010145937.lkknbbrt5vznjlat@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 01:41:33PM +0200, Paul Kocialkowski wrote:
> This adds the pin muxing definition for configuring the PD pins in LCD0
> mode for a RGB888 format to the sun7i device-tree.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

OUr policy so far has been that if there's no user for that pin group,
we won't merge it in order not to cripple the DTSI with useless groups.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
