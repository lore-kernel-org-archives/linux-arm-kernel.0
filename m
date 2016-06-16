From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Jun 2016 09:57:15 +0200
Subject: [PATCH v2] ARM: sunxi/dt: make the CHIP inherit from
 allwinner,sun5i-a13
In-Reply-To: <20160615132149.2587c195@bbrezillon>
References: <1465989619-2337-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160615132149.2587c195@bbrezillon>
Message-ID: <20160616075715.GF5144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 01:21:49PM +0200, Boris Brezillon wrote:
> On Wed, 15 Jun 2016 13:20:19 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
> > The sun4i-timer driver registers its sched_clock only if the machine is
> > compatible with "allwinner,sun5i-a13", "allwinner,sun5i-a10s" or
> > "allwinner,sun4i-a10".
> > Add the missing "allwinner,sun5i-a13" string to the machine compatible.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Fixes: 5a33893dd079 ("ARM: sunxi/dt: make the CHIP inherit from allwinner,sun5i-a13")
> 
> Should be
> 
> Fixes: 465a225fb2af ("ARM: sun5i: Add C.H.I.P DTS")
> 
> Maxime, do you want me to resend it?

No, it's fine. I fixed it and applied.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160616/03a1fe9c/attachment.sig>
