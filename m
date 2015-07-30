From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 30 Jul 2015 10:49:27 +0200
Subject: [RESEND PATCH] pinctrl: at91: fix null pointer dereference
In-Reply-To: <20150730083343.GA23018@gradator.net>
References: <20150715133048.GD14886@odux.rfo.atmel.com>
 <1438069696-25303-1-git-send-email-ludovic.desroches@atmel.com>
 <CACRpkdaiwcTzxG=KqPZxk6ijLOE0PAh9ybkNqUYhkmAcQV40eg@mail.gmail.com>
 <20150728131253.GA4055@odux.rfo.atmel.com>
 <20150730083343.GA23018@gradator.net>
Message-ID: <20150730084927.GC4055@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 10:33:43AM +0200, Sylvain Rochet wrote:
> Hello Ludovic,
> 
> On Tue, Jul 28, 2015 at 03:12:53PM +0200, Ludovic Desroches wrote:
> > On Tue, Jul 28, 2015 at 02:48:09PM +0200, Linus Walleij wrote:
> > > On Tue, Jul 28, 2015 at 9:48 AM, Ludovic Desroches

[...]

> > > Is this a regression to v4.2 that should go to stable or v4.3 material?
> > 
> > Yes it is a regression from v4.0, it applies well on v4.0.9
> > 
> > Fixes: a0b957f306fa ("pinctrl: at91: allow to have disabled gpio bank")
> > Cc: stable at vger.kernel.org # 4.0
> 
> a0b957f306fa have a stable tag up to 3.18, should this patch inherit a 
> stable tag up to 3.18 instead of only up to 4.0 ?
> 

Well spotted, I didn't notice it has hit 3.18 through stable, so yes
stable tag should be 3.18 and later.

Thanks

Ludovic
