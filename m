From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Apr 2011 19:33:16 +0200
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <1304009792.3081.8.camel@redbox>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
	<BANLkTi=2_9Xcz45jyOnbxv6xwC2R5U__VA@mail.gmail.com>
	<20110428113427.GG17290@n2100.arm.linux.org.uk>
	<20110428131538.GA10594@game.jcrosoft.org>
	<1304009792.3081.8.camel@redbox>
Message-ID: <20110428173316.GC10594@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:56 Thu 28 Apr     , Andrew Victor wrote:
> hi,
> 
> > > And that's another reason to say no to this.  Please stop inventing new
> > > ways to do things unless you're prepared to provide it as a replacement
> > > for all the (ARM) platforms we have in the kernel.
> > Personally I do not change the current arm way
> > 
> > I init the timer during system_timer->init
> > 
> > I just the the early device their to pass the resources
> > but if switch all arm timer this way is fine to you I'm ready to do the whole
> > update
> 
> Well, attached is a simpler way of passing the base-address to the timer
> drivers.  It will solve the timer issues with a single kernel supporting
> multiple AT91 processors.
I really don't like the idea of having global var for driver

Best Regards,
J.
