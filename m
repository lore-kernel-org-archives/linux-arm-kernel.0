From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 14 Mar 2014 10:13:53 +0100
Subject: [PATCH v3 1/2] i2c: sunxi: Change i2c compatibles
In-Reply-To: <20140313173128.GC25870@e106331-lin.cambridge.arm.com>
References: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394710643-3411-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140313173128.GC25870@e106331-lin.cambridge.arm.com>
Message-ID: <20140314091353.GK2815@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 05:31:28PM +0000, Mark Rutland wrote:
> On Thu, Mar 13, 2014 at 11:37:22AM +0000, Maxime Ripard wrote:
> > The Allwinner A10 compatibles were following a slightly different compatible
> > patterns than the rest of the SoCs for historical reasons. Move to the other
> > pattern for consistency across all Allwinner Socs.
> 
> Dropping support for the existing string breaks existing DTBs. Is
> this really necessary?

I added new ones at first, and Rob said it wasn't worth it since we
were a "work-in-progress" platform.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/229438.html

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140314/8d5d4eb4/attachment.sig>
