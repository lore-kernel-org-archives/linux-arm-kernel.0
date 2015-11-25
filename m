From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 25 Nov 2015 18:34:20 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151125160937.GJ14338@lunn.ch> (Andrew Lunn's message of "Wed,
 25 Nov 2015 17:09:37 +0100")
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <20151125160937.GJ14338@lunn.ch>
Message-ID: <87wpt67zkz.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
 
 On mer., nov. 25 2015, Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Nov 25, 2015 at 04:49:12PM +0100, Arnd Bergmann wrote:
>> I've posted these before and now gotten around to a rebase and
>> want to include them in the arm-soc next/multiplatform branch for
>> 4.5.
>> 
>> Originally the plan for these platforms was to convert all of
>> them to DT and use only mach-mvebu. That has not happened,
>> so I would do it this way instead so we can at least have
>> them in a single kernel.
>> 
>> Let me know if there are any concerns or objections.
>
> Maybe we should just remove mv78xx0? It has been at least two years
> since we have heard of anybody using it, outside of Debians now
> replaced build system. And its IRQ handling is broken apparently.

Actually I was about to remove it last year but an mv78200 user came
with a bug fix on the gpio driver used by this platform:
http://marc.info/?l=linux-arm-kernel&m=140639461108781&w=2

While he seemed interseted to use a mainline kernel we don't have any
news for one year:
http://marc.info/?l=linux-arm-kernel&m=141391779222342&w=2

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
