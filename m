From: tony@atomide.com (Tony Lindgren)
Date: Thu, 29 May 2014 12:17:39 -0700
Subject: [PATCH] ARM: OMAP: SX1: remove check for CONFIG_SX1_OLD_FLASH
In-Reply-To: <20140529190227.GB18230@amd.pavel.ucw.cz>
References: <1400182902.11786.21.camel@x220>
 <20140516211231.GF12881@atomide.com>
 <20140529190227.GB18230@amd.pavel.ucw.cz>
Message-ID: <20140529191738.GA18567@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [140529 12:03]:
> On Fri 2014-05-16 14:12:31, Tony Lindgren wrote:
> > * Paul Bolle <pebolle@tiscali.nl> [140515 12:42]:
> > > A check for CONFIG_SX1_OLD_FLASH was added in v2.6.24. But the related
> > > Kconfig symbol was never part of the tree. So we can remove some dead
> > > code.
> > 
> > Thanks applying into omap-for-v3.16/board.
> 
> Actually... It seems there are two variant of SX1, and this is very
> useful piece of documentation how the _other_ variant looks.
> 
> And if someone is hacking linux on sx1, he can probably figure out
> #ifdef in .c file...
> 
> IOW adding the config option might be better solution.

Or just a comment saying the same?

Regards,

Tony
