From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Mar 2012 13:45:52 +0000
Subject: [PATCH v9] Regulator: Add Anatop regulator driver
In-Reply-To: <20120307132225.GB17745@game.jcrosoft.org>
References: <1331126658-26926-1-git-send-email-paul.liu@linaro.org>
 <20120307132225.GB17745@game.jcrosoft.org>
Message-ID: <20120307134551.GL3107@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 02:22:25PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> > +- compatible: Must be "fsl,anatop-regulator"
> > +- vol-bit-shift: Bit shift for the register
> > +- vol-bit-width: Number of bits used in the register
> > +- min-bit-val: Minimum value of this register
> > +- min-voltage: Minimum voltage of this regulator
> > +- max-voltage: Maximum voltage of this regulator

> specific properites need to be prefix by the vendor

This really doesn't seem at all sane for a device which is already
vendor specific, it's just noise in the bindings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120307/0c5ee8b7/attachment.sig>
