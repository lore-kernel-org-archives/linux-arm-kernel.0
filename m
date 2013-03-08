From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Mar 2013 10:10:29 -0800
Subject: [PATCH] ARM: OMAP: drop "select MACH_NOKIA_RM696"
In-Reply-To: <1362765764.5994.87.camel@x61.thuisdomein>
References: <1362738596.5994.48.camel@x61.thuisdomein>
 <20130308161159.GE14552@blackmetal.musicnaut.iki.fi>
 <20130308163507.GC26093@atomide.com>
 <1362763232.5994.75.camel@x61.thuisdomein>
 <20130308175539.GG26093@atomide.com>
 <1362765764.5994.87.camel@x61.thuisdomein>
Message-ID: <20130308181029.GF11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Bolle <pebolle@tiscali.nl> [130308 10:06]:
> On Fri, 2013-03-08 at 09:55 -0800, Tony Lindgren wrote:
> > * Paul Bolle <pebolle@tiscali.nl> [130308 09:24]:
> > > Should I draft a patch?
> > 
> > Sure that would be nice.
> 
> One thing I couldn't determine is how the generated mach-types.h header
> handles multiple CONFIG_MACH_* macros.
> 
> If both CONFIG_MACH_FOO and CONFIG_MACH_BAR are defined, and these both
> have a line in */mach-types, will the machine_is_foo() and
> machine_is_bar() macros both behave as one would expect?

Yes they do, for the selected ones the macro becomes
machine_arch_type == MACH_TYPE_XYZ instead of 0.

Regards,

Tony
