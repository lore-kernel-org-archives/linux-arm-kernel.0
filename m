From: balbi@ti.com (Felipe Balbi)
Date: Fri, 25 Jul 2014 11:53:04 -0500
Subject: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <alpine.DEB.2.02.1407222110260.25593@utopia.booyaka.com>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1407222110260.25593@utopia.booyaka.com>
Message-ID: <20140725165304.GD29132@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 09:14:20PM +0000, Paul Walmsley wrote:
> On Tue, 17 Jun 2014, Tomi Valkeinen wrote:
> 
> > From: Sathya Prakash M R <sathyap@ti.com>
> > 
> > Add DSS hwmod data for AM43xx.
> > 
> > Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> > [tomi.valkeinen at ti.com: added missing dispc flags]
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Acked-by: Rajendra Nayak <rnayak@ti.com>
> 
> This one didn't compile on an AM43xx-only build:
> 
> ----
> arch/arm/mach-omap2/built-in.o:(.data+0x3f2c): undefined reference to `omap2_dss_hwmod_class'
> arch/arm/mach-omap2/built-in.o:(.data+0x405c): undefined reference to `omap2_rfbi_hwmod_class'
> make: *** [vmlinux] Error 1
> test_build: Tue Jul 22 13:48:50 MDT 2014: FAILED on omap2plus_defconfig_am43xx_only hwmod-a-v3.17
> ----
> 
> Have queued the following patch instead.

queued for v3.17, I assume. Still not available from linux-next though.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/a010bda4/attachment.sig>
