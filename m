From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 02 Apr 2012 14:08:45 +0300
Subject: [PATCH 0/5] mtd: plat_nand: Add default partition parser and
 use it
In-Reply-To: <201203281112.48788.hartleys@visionengravers.com>
References: <201203281112.48788.hartleys@visionengravers.com>
Message-ID: <1333364925.5440.104.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-03-28 at 11:12 -0700, H Hartley Sweeten wrote:
> This patch series adds cmdlinepart as the default partition parser for the
> plat_nand driver and updates all the arch setup code to use it.
> 
> Arch setup code that requires other partition parsers can still pass that
> information as chip.part_probe_types.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Pushed the series to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120402/61fd9a90/attachment.sig>
