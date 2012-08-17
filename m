From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 17 Aug 2012 14:10:35 +0300
Subject: [PATCH] ARM: LPC32xx: Provide DMA filter callbacks via platform
 data
In-Reply-To: <1345201311.27859.51.camel@sauron.fi.intel.com>
References: <1345122935-22115-1-git-send-email-stigge@antcom.de>
 <1345198171.27859.39.camel@sauron.fi.intel.com>
 <502E2279.1030604@antcom.de>
 <1345201311.27859.51.camel@sauron.fi.intel.com>
Message-ID: <1345201835.27859.52.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-17 at 14:01 +0300, Artem Bityutskiy wrote:
> > To later avoid collisions on subsystem merge, can you please leave the
> > patch with arch/arm/mach-lpc32xx/phy3250.c for arm-soc.git? (I will
> > provide a pull request for Arnd and Olof, as usual.)
> 
> Only if Arnd insists. Otherwise I'd prefer to resolve collisions (they
> cannot be hard with this patch) than pulling the soc tree to the mtd
> tree.

Actually the mtd patches do not compile-depend on it, sorry, I am
dropping it from the MTD tree. Thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/bbd3ec00/attachment.sig>
