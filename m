From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 29 Sep 2015 19:19:22 -0400 (EDT)
Subject: [PATCH 1/1] Disable CONFIG_UACCESS_WITH_MEMCPY in Atmel config.
In-Reply-To: <20150929225317.GA9993@piout.net>
References: <1443556987-2788-1-git-send-email-jc@eclis.ch>
 <20150929203554.GH3982@pengutronix.de> <560AFBC2.5050000@eclis.ch>
 <20150929220140.GA3639@piout.net>
 <20150929221800.GR21513@n2100.arm.linux.org.uk>
 <20150929225317.GA9993@piout.net>
Message-ID: <alpine.LFD.2.20.1509291917520.11346@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Sep 2015, Alexandre Belloni wrote:

> On 29/09/2015 at 23:18:01 +0100, Russell King - ARM Linux wrote :
> > On Wed, Sep 30, 2015 at 12:01:40AM +0200, Alexandre Belloni wrote:
> > > Hi,
> > > 
> > > On 29/09/2015 at 22:59:46 +0200, Jean-Christian de Rivaz wrote :
> > > > Without the explicit disabling, the user will be asked and could possibly
> > > > give the wrong answer as the help look as a cool feature and the condition
> > > > is very hard to understand.
> > > > 
> > > 
> > > That is not true, if you remove it from the defconfig, it will simply be
> > > disabled in the final config.
> > > 
> > > Moreover, I would prefer a better commit message than "Russell said so"
> > 
> > Well, if people are going to take that kind of attitude, then I'm not
> > going to bother fixing it at all.  I've got better things to do than
> > chase after bugs in almost unused code and code which people shouldn't
> > be enabling on their platforms.
> > 
> > It's not "Russell said so" but "Nicolas, the author of the code, said so."
> > I'm merely passing the information along.  Search the archives if you don't
> > believe me, it's been discussed in the last couple of months, including
> > potentially removing this code.
> > 
> > I regard this code as a maintanence burden, one that I personally can do
> > without.
> > 
> 
> Come on, I never said it was not worth fixing, I'm just saying the
> commit message doesn't carry the proper explanation. I would prefer
> something a bit more technical.
> A better commit message could point to the discussion you are referring
> to for example so that the maintainers (btw they are not in copy) don't
> have to look it up themselves.

FYI: here is the thread:

http://article.gmane.org/gmane.linux.ports.arm.kernel/433489


Nicolas
