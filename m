From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 08 Mar 2013 18:20:32 +0100
Subject: [PATCH] ARM: OMAP: drop "select MACH_NOKIA_RM696"
In-Reply-To: <20130308163507.GC26093@atomide.com>
References: <1362738596.5994.48.camel@x61.thuisdomein>
 <20130308161159.GE14552@blackmetal.musicnaut.iki.fi>
 <20130308163507.GC26093@atomide.com>
Message-ID: <1362763232.5994.75.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-03-08 at 08:35 -0800, Tony Lindgren wrote:
> I think the righ fix is to just add
> 
> config MACH_NOKIA_RM680
> 	bool

I guess you meant MACH_NOKIA_RM696.

> to the mach-omap2/Kconfig like we have for n8x0 also.

Should I draft a patch?


Paul Bolle
