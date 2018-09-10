From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 10 Sep 2018 13:43:11 +0200
Subject: [PATCH RESEND] drivers: soc: Allow building the sunxi driver
 without ARCH_SUNXI
In-Reply-To: <20180909190439.20425-1-contact@paulk.fr>
References: <20180909190439.20425-1-contact@paulk.fr>
Message-ID: <20180910114311.6fw3iwend3js7mcf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 09, 2018 at 09:04:39PM +0200, Paul Kocialkowski wrote:
> This makes it possible to build the sunxi SRAM driver without building
> for the sunxi architecture. This allows selecting the driver when
> building the kernel in testing environments.
> 
> In particular, this is necessary for testing of the Cedrus driver, that
> selects the sunxi SRAM driver.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180910/9568d060/attachment.sig>
