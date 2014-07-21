From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 21 Jul 2014 07:51:44 +0200
Subject: [PATCH] spi: omap2-mcspi: fix blatant abuse of the resource
 subsystem
In-Reply-To: <20140718171035.GQ17528@sirena.org.uk>
References: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
 <20140718171035.GQ17528@sirena.org.uk>
Message-ID: <20140721075144.251bb67d@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Mark Brown wrote:
> On Fri, Jul 18, 2014 at 01:30:53PM +0200, Lothar Wa?mann wrote:
> > Aua. This really hurts. I wonder how this could ever be admitted to
> > the Linux kernel...
> > Further comments suppressed because the would most likely violate the
> > CDA.
> > 
> > If someone should not grasp what this patch does, they should consider
> > what happens upon unloading/reloading the kernel module.
> > 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> 
> I'm not going to apply this with a commit message such as the above.
> Quite aside from the tone the fact that it doesn't describe the issue
> is not helpful for review, one of the things done in review is to try to
> check that the change has the intended effect.
>
Maybe the original author or the maintainer who accepted this can come
up with a decent fix for this.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
