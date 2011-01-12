From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 10:32:46 +0100
Subject: [PATCH v2] ARM: Change misleading warning when
	CONFIG_CMDLINE_FORCE is used
In-Reply-To: <20110112091716.GU11039@n2100.arm.linux.org.uk>
References: <1294789556-3870-1-git-send-email-holler@ahsoftware.de>
	<20110112081147.GA24920@pengutronix.de>
	<20110112091716.GU11039@n2100.arm.linux.org.uk>
Message-ID: <20110112093246.GA25718@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Wed, Jan 12, 2011 at 09:17:16AM +0000, Russell King - ARM Linux wrote:
> > Does it make sense at all to disable CONFIG_CMDLINE_FORCE?  If not, I
> > suggest to remove it.
> 
> Eeh?  Do you understand what CONFIG_CMDLINE_FORCE is and what effect it
> has?
> 
> When CONFIG_CMDLINE_FORCE is enabled, we ignore the command line passed
> in from the boot loader and always use the built-in command line.  When
> CONFIG_CMDLINE_FORCE is disabled, we will use the boot loader supplied
> command line if present.
> 
> "Does it make sense at all to disable CONFIG_CMDLINE_FORCE" so, if you
> always have it enabled, you can never pass in a command line from a boot
> loader.  That's an absolutely idiotic idea.
> 
> _Most_ of us want to pass in command lines from the boot loader so we can
> configure things.
ah, I thought the effect of CONFIG_CMDLINE_FORCE would be its inverse.
And ok, this is probably about broken boot loaders that I'm just not
used to.
 
> Please, if you don't understand, ask questions rather than making
> completely misleading review comments which may confuse patch submitters.
IMHO "Does it make sense at all to disable CONFIG_CMDLINE_FORCE?" is a
question, isn't it?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
