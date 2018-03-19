From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Mar 2018 22:13:22 +0100
Subject: [PATCH 0/8] ARM: sun9i: a80: Add display support
In-Reply-To: <20180315114136.24747-1-wens@csie.org>
References: <20180315114136.24747-1-wens@csie.org>
Message-ID: <20180319211322.gnbc4mgk4nn2uskg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 07:41:28PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This series adds basic support for the display pipelines found on the
> Allwinner A80 SoC. Currently only parallel RGB output via TCON0 is
> supported. TCON1 drives the HDMI encoder, which I've not been able to
> get working yet.
> 
> Patch 1 adds device tree bindings for the TCONs on the A80. In
> particular, TCON0 requires the eDP reset control in addition to its own.
> 
> Patch 2 adds a device tree binding for the Detail Enhancement Unit found
> only on the A80.
> 
> Patch 3 adds driver support for the TCONs.
> 
> Patch 4 adds compatible strings to the device tree bindings for all the 
> remaining peripherals covered by this series.
> 
> Patch 5 adds support for the compatible strings from the previous patch
> to the sun4i-drm driver.
> 
> Patch 6 adds the display pipeline device nodes to the A80 .dtsi file.
> 
> Patch 7 adds a pinmux setting for RGB888 output for TCON0.
> 
> Patch 8 enables VGA output on the Cubieboard4 via an external DAC and
> an I2C bus from the SoC for DDC.
> 
> 
> I've had these patches for quite some time now, rebasing them as more
> features were added to sun4i-drm. Please have a look.

Applied all, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180319/2a2f6472/attachment.sig>
