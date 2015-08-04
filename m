From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 4 Aug 2015 13:00:44 +0200
Subject: [PATCH 19/20] clocksource: atmel-st: get and use slow clock
In-Reply-To: <55C09477.3080209@linaro.org>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438215726-27452-20-git-send-email-alexandre.belloni@free-electrons.com>
 <55C09477.3080209@linaro.org>
Message-ID: <20150804110044.GK3486@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2015 at 12:31:19 +0200, Daniel Lezcano wrote :
> On 07/30/2015 02:22 AM, Alexandre Belloni wrote:
> >The current slow clock rate is hardcoded. Properly get the slow clock
> >and use its rate.
> >
> >Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >---
> 
> [ ... ]
> 
> >+struct clk *sclk;
> 
> Do you need this variable global ? AFAICS, its scope is in the init
> function, no ?
> 

Indeed.

> >+int timer_latch;
> 
> static.
> 

Yeah, this was changed in v2 (that I forgot to label as v2).

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
