From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 08 Apr 2011 05:38:54 +0200
Subject: [PATCH 0/2] ARM: Unify setup for Marvell SheevaPlugs and	Seagate
	DockStars
In-Reply-To: <20110407173912.GA17049@n2100.arm.linux.org.uk>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<4D9CEE24.1080501@erfurth.eu> <4D9D81ED.7090809@ahsoftware.de>
	<4D9D85E4.2040606@erfurth.eu> <4D9D8762.3080207@ahsoftware.de>
	<20110407173912.GA17049@n2100.arm.linux.org.uk>
Message-ID: <4D9E834E.2030705@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.04.2011 19:39, schrieb Russell King - ARM Linux:

> We have an established API and convention in the kernel which you claim
> is "from outerspace".  It's not "from outerspace" but a designed API to
> allow platforms to live together in the same kernel image.  So I find
> your arguments totally unreasonable.

I've claimed that the specific machine ID is from outerspace not the 
API. This one (ID) got invented just because of a different usage of two 
GPIOs (and not even by the manufacturerer). And I still think using the 
(fixed) memory size here is totally reasonable. There is nothing else to 
differentiate these HWs, it's extremely unlikely that this difference 
will get proved wrong, and if that would really happen, than one could 
still add some code to fix this specific problem. _Always_ dealing with 
"what happens when" is (imho) fruitless and no solution or API can deal 
with everything.

> I fully support Nicolas in rejecting your patches outright on this point
> alone.

Which I fully understand. And I wouldn't have started to defend me, if 
that would have happened in a more civil language.

But because I don't want to get involved in more discussions with people 
who are missing the needed manners (at least how I learned them) to talk 
with other people without offending them (not you), I better try to stay 
away posting patches.

Maybe I'm getting too old and lacking the needed enthusiasm needed to 
discuss such stuff (and with everyone who thinks he must enter this 
discussion too, again, not you). ;)

I wish you all a nice day,

Alexander
