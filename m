From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 21 Jul 2014 14:41:04 +0200
Subject: [PATCH] spi: omap2-mcspi: fix blatant abuse of the resource
 subsystem
In-Reply-To: <20140721121820.GW17528@sirena.org.uk>
References: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
 <20140718171035.GQ17528@sirena.org.uk>
 <20140721075144.251bb67d@ipc1.ka-ro>
 <20140721121820.GW17528@sirena.org.uk>
Message-ID: <20140721144104.5e37f1a0@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Mark Brown wrote:
> On Mon, Jul 21, 2014 at 07:51:44AM +0200, Lothar Wa?mann wrote:
> > Mark Brown wrote:
> 
> > > I'm not going to apply this with a commit message such as the above.
> > > Quite aside from the tone the fact that it doesn't describe the issue
> > > is not helpful for review, one of the things done in review is to try to
> > > check that the change has the intended effect.
> 
> > Maybe the original author or the maintainer who accepted this can come
> > up with a decent fix for this.
> 
> Just to be clear the issue is with the presentation of your change, it
> is not appropriate to provide a changelog which consists mainly of
> widely directed personal insults especially given that it omits basic
> technical content.
>
I understood that, but I feel incapable to come up with a reasonable
changelog for this.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
