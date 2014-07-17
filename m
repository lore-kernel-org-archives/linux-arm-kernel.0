From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Jul 2014 19:49:44 +0100
Subject: [PATCH 4/4] ARM: DTS: fix the chip select gpios definition in
 the SPI nodes
In-Reply-To: <1405523950-2231-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
 <1405523950-2231-5-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140717184944.GE17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 05:19:10PM +0200, Javier Martinez Canillas wrote:
> From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> 
> This patch replaces the "cs-gpio" from "controller-data" node
> as was specified in the old binding and uses the standard
> "cs-gpios" property expected by the SPI core as is defined now
> in the spi-s3c64xx driver DT binding.

I've applied this one too since everything here really ought to go in
together and we should probably try to get this into v3.16 - Kukjin,
please say if this is an issue and I can revert.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/b479e79f/attachment.sig>
