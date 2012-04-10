From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Apr 2012 09:35:43 +0100
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <20120410083130.GK24211@n2100.arm.linux.org.uk>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120406074942.GO7264@S2101-09.ap.freescale.net>
 <20120410083130.GK24211@n2100.arm.linux.org.uk>
Message-ID: <20120410083543.GC3149@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 09:31:30AM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 06, 2012 at 03:49:45PM +0800, Shawn Guo wrote:
> > I believe this patch fixes the amba probe failure that impacts any
> > AMBA platform build with CONFIG_REGULATOR enabled.  Could you consider
> > to send the fix for -rc soon?

> No idea.  I don't have Mark's patch in the patch system.

It's there as far as I can tell - it's 7366/1, which is visible in the
web interface at:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7366/1

Is there something else I need to do?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120410/f8948335/attachment.sig>
