From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 19 Jun 2015 13:48:37 +0200
Subject: [PATCH 31/41] clocksource: atmel-st: Migrate to new 'set-state'
 interface
In-Reply-To: <20150619014951.GB4376@linux>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <641cb53b1a3f8697340ae8a96e6734be44c7de47.1434622147.git.viresh.kumar@linaro.org>
 <20150618144000.GH27492@piout.net> <20150619014951.GB4376@linux>
Message-ID: <20150619114837.GU27492@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/06/2015 at 07:19:51 +0530, Viresh Kumar wrote :
> On 18-06-15, 16:40, Alexandre Belloni wrote:
> > Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Thanks.
> 
> > I think that anyway I'm the only one booting a kernel from after 3.0 on
> > the rm9200. I'll test boot that when 4.3-rc1 is released.
> 
> What about testing it now on top of clockevents tree which I have
> mentioned in the cover letter ?
> 

I just did.

I was not being lazy but booting that board is actually time consuming
for multiple reasons and time is a scarce resource ;)



-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
