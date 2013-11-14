From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 14 Nov 2013 19:37:52 -0300
Subject: [PATCH v5 03/14] mtd: nand: pxa3xx: Add bad block handling
In-Reply-To: <20131114221212.GR9468@ld-irv-0074.broadcom.com>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1384464339-6817-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131114221212.GR9468@ld-irv-0074.broadcom.com>
Message-ID: <20131114223751.GA24184@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:12:12PM -0800, Brian Norris wrote:
> On Thu, Nov 14, 2013 at 06:25:28PM -0300, Ezequiel Garcia wrote:
> > --- a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
> > +++ b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
> > @@ -15,6 +15,8 @@ Optional properties:
> >   - marvell,nand-keep-config:	Set to keep the NAND controller config as set
> >  				by the bootloader
> >   - num-cs:			Number of chipselect lines to usw
> > + - nand-on-flash-bbt: 		boolean to enable on flash bbt option if
> > +				not present false
> 
> It's not really your problem, but I just noticed that this binding
> description is particularly badly worded! No need to change it in this
> patch, since it's a copy-and-paste from the generic nand.txt, but it's
> probably worth rewriting all of them sometime.
> 

Indeed. And it's a bit embarrasing that I did such obviously mediocre
copy-paste.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
