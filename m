From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Feb 2012 21:18:10 +0100
Subject: [RFC PATCH 00/11] Cortex-M3 support
In-Reply-To: <20120122111230.GB14835@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
Message-ID: <20120207201810.GF8621@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2012 at 12:12:30PM +0100, Uwe Kleine-K?nig wrote:
> this series is mostly a port of patches done by Catalin Marinas for
> 2.6.33. It's based on 3.3-rc1. There are still a few rough edges and I'm
> sure I'm not aware of all of them as this deep architecture stuff is
> mostly news for me. Some things are noted in the respective patches, I'm
> sure you can find more.
> 
> My target machine is the EFM32 Giant Gecko by Energy Micro and my
> complete tree can be found at
> 
> 	git://git.pengutronix.de/git/ukl/linux.git efm32
> 
> (with a gitweb being available at
> 
> 	http://git.pengutronix.de/?p=ukl/linux.git;a=shortlog;h=efm32
> 
> ).
> 
> I look forward to your comments.
I didn't get much comments apart from a few trivial ones. I'd like to
plan how to go forward here.

Catalin, Russell, I guess it's just lack of time on your side that you
didn't comment?

There are a few things to fix and follow up (e.g. platform support,
ftrace, adapt unwinding to the v7m model), but I first want to see the
base patches in before I invest the time to address these.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
