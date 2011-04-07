From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 Apr 2011 12:58:50 +0200
Subject: [PATCH] ARM: Allow for kernel command line concatenation
In-Reply-To: <1302172525.24493.7.camel@t41.thuisdomein>
References: <1302164236-1516-1-git-send-email-oskar.andero@sonyericsson.com>
	<1302172525.24493.7.camel@t41.thuisdomein>
Message-ID: <20110407105850.GJ13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2011 at 12:35:01PM +0200, Paul Bolle wrote:
> On Thu, 2011-04-07 at 10:17 +0200, oskar.andero at sonyericsson.com wrote:
> > +config CMDLINE_EXTEND
> > +	bool "Extend bootloader kernel arguments"
> > +	depends on CMDLINE != ""
> > +	help
> > +	  The default kernel command string will be concatenated with the
> > +	  arguments provided by the boot loader.
> 
> This suggests the parameters provided by the boot loader will override
> corresponding parameters of the default kernel command string. Is that
> correct (for all possible parameters)?
> 
> Either way, shouldn't it be documented, perhaps in this help text, what
> will happen if a parameter of the default kernel command string and a
> parameter provided by the boot loader somehow conflict?
Then you will end up with both parameters I guess. What happens depends
on the parameter in question I guess. IMHO the description is fine.
But I wonder if the new mechanism is useful in the end.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
