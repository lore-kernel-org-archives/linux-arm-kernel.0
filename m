From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri, 23 May 2014 02:24:55 +0200
Subject: [PATCH 0/5] ARM: omap3-lilly-a83x: update board support
In-Reply-To: <20140522232854.GD29577@atomide.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
 <20140522232854.GD29577@atomide.com>
Message-ID: <1400804695.29278.2.camel@mars>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-05-22 at 16:28 -0700, Tony Lindgren wrote:
> * Christoph Fritz <chf.fritz@googlemail.com> [140522 16:07]:
> > This set of patches updates board support for omap3-lilly-a83x.
> > 
> > Christoph Fritz (5):
> >   [RFC-HACK] pinctrl-single: init by postcore_initcall()
> 
> I would prefer to start initializing other things later as
> then we get proper error messages on the console. Let's first
> investigate a bit more if we can just initialize other
> drivers later on.
> 
> Which version of kernel are you using? With all the fixes
> that have gone into this -rc cycle, v3.15-rc4 is pretty much
> the first kernel that should behave for us properly for
> deferred probe for irqchips that get initialized later on.

It's 3.15-rc6.
