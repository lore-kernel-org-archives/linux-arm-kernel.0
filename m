From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Mar 2013 09:33:52 -0700
Subject: [PATCH] ARM: OMAP: drop "select MACH_NOKIA_RM696"
In-Reply-To: <1362858510.3137.31.camel@x61.thuisdomein>
References: <1362738596.5994.48.camel@x61.thuisdomein>
 <20130308161159.GE14552@blackmetal.musicnaut.iki.fi>
 <20130308163507.GC26093@atomide.com>
 <1362763232.5994.75.camel@x61.thuisdomein>
 <20130308175539.GG26093@atomide.com>
 <1362765764.5994.87.camel@x61.thuisdomein>
 <20130309000157.GE30923@n2100.arm.linux.org.uk>
 <1362858510.3137.31.camel@x61.thuisdomein>
Message-ID: <20130311163351.GJ26093@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Bolle <pebolle@tiscali.nl> [130309 11:52]:
> On Sat, 2013-03-09 at 00:01 +0000, Russell King - ARM Linux wrote:
> 
> > However, going back to that MACH_NOKIA_RM696.  If there exists only a
> > select of this symbol and no "config MACH_NOKIA_RM696" entry, then the
> > symbol will never be generated in the output .config file.
> > 
> >[...]
> > 
> > My conclusion is... it's a mess.
> 
> That mess can only be fully cleaned up if the code for the RM-696 that
> now is maintained in some unknown to me repository gets merged into
> mainline, can't it?
>
> In the meantime, how do you prefer I solve the (trivial) issue of an
> useless select for MACH_NOKIA_RM696? Drop that select or add an (equally
> useless) config entry for MACH_NOKIA_RM696? Or should I try to ignore it
> for the time being?

Just adding the config MACH_NOKIA_RM696 to Kconfig as bool should fix
this unless I'm missing something here.

Regards,

Tony
