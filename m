From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 14 Mar 2013 09:00:14 +0100
Subject: [PATCH] ARM: OMAP: drop "select MACH_NOKIA_RM696"
In-Reply-To: <20130311163351.GJ26093@atomide.com>
References: <1362738596.5994.48.camel@x61.thuisdomein>
 <20130308161159.GE14552@blackmetal.musicnaut.iki.fi>
 <20130308163507.GC26093@atomide.com>
 <1362763232.5994.75.camel@x61.thuisdomein>
 <20130308175539.GG26093@atomide.com>
 <1362765764.5994.87.camel@x61.thuisdomein>
 <20130309000157.GE30923@n2100.arm.linux.org.uk>
 <1362858510.3137.31.camel@x61.thuisdomein>
 <20130311163351.GJ26093@atomide.com>
Message-ID: <1363248014.1335.23.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-11 at 09:33 -0700, Tony Lindgren wrote:
> * Paul Bolle <pebolle@tiscali.nl> [130309 11:52]:
> > In the meantime, how do you prefer I solve the (trivial) issue of an
> > useless select for MACH_NOKIA_RM696? Drop that select or add an (equally
> > useless) config entry for MACH_NOKIA_RM696? Or should I try to ignore it
> > for the time being?
> 
> Just adding the config MACH_NOKIA_RM696 to Kconfig as bool should fix
> this unless I'm missing something here.

Yes, that should do. I already promised to draft that small patch last
week. I hope to actually do that shortly.


Paul Bolle
