From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 13 Feb 2012 08:56:18 -0800
Subject: [PATCH] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
In-Reply-To: <20120213165209.GA31482@n2100.arm.linux.org.uk>
References: <1329151422-2146-1-git-send-email-mporter@ti.com>
 <20120213165209.GA31482@n2100.arm.linux.org.uk>
Message-ID: <20120213165617.GE3494@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 04:52:09PM +0000, Russell King - ARM Linux wrote:

> I think OMAP (or even the reg-fixed-voltage folk) needs to create an enum
> similar to what I did for 8250 to control the allocation of platform
> device IDs for this, otherwise we're going to keep on running over this
> problem.

> Added Mark for his comment.

Hrm, seems slightly icky but the enum will work if we can decide how to
add elements to the enum since it'll be easy to bloat a lot it if it's
central.  It's tempting to suggest just using a random number to assign
the IDs randomly rather than have a central registry but obviously
there's no guarantees there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120213/9f69c9d0/attachment.sig>
