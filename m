From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Sep 2014 09:16:13 -0700
Subject: [PATCH] ARM: zynq: Add ISL9305 regulator on Parallella board
In-Reply-To: <5416EA84.5070905@suse.de>
References: <1410003616-32077-1-git-send-email-broonie@kernel.org>
 <5999bc23-b615-4b76-acec-ba2ee5675a03@BN1AFFO11FD035.protection.gbl>
 <5416EA84.5070905@suse.de>
Message-ID: <20140915161613.GR7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 03:32:52PM +0200, Andreas F?rber wrote:
> Am 15.09.2014 um 15:26 schrieb Michal Simek:

> > Applied.

> Where exactly on the board did you spot that regulator? I did not spot
> it on my pre-ordered board and wonder whether it might be a difference
> of the revised RS-distributed board with the large heat sink?

I didn't actually identify the physical device on the board, it's on
sheet 16 of the schematic.  The device is responsive to I2C and I'm
reading back the settings I'm expecting from the hardware.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140915/eea459d4/attachment.sig>
