From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 6 May 2011 14:28:30 +0200
Subject: [PATCH] avr32: add some more at91 to cpu.h definition
In-Reply-To: <4DC3EA35.5030709@atmel.com>
References: <1304680123-20218-1-git-send-email-nicolas.ferre@atmel.com>
	<1304683480.3025.2.camel@hcegtvedt.norway.atmel.com>
	<4DC3EA35.5030709@atmel.com>
Message-ID: <20110506122830.GJ11267@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:31 Fri 06 May     , Nicolas Ferre wrote:
> Le 06/05/2011 14:04, Hans-Christian Egtvedt :
> > On Fri, 2011-05-06 at 13:08 +0200, Nicolas Ferre wrote:
> >> Somme common drivers will need those at91 cpu_is_xxx() definitions.
> >> Those definitions are already in Linus' tree so if we want to use them
> >> in common drivers, we will need them in AVR32 cpu.h file.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > Will you push this update for 2.6.39? I don't have anything for Linus
> > right now.
> 
> Ah, Linus has just pulled from our tree...
> Maybe we can wait a few days to see if some fixes have to be pushed
> upstream before -final...
> 
> > Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> > with one comment...
I've a bug fix for udc but nothing more
maybe map_io fix can go now

Best Regards,
J.
