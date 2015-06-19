From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 19 Jun 2015 07:19:51 +0530
Subject: [PATCH 31/41] clocksource: atmel-st: Migrate to new 'set-state'
 interface
In-Reply-To: <20150618144000.GH27492@piout.net>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <641cb53b1a3f8697340ae8a96e6734be44c7de47.1434622147.git.viresh.kumar@linaro.org>
 <20150618144000.GH27492@piout.net>
Message-ID: <20150619014951.GB4376@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-06-15, 16:40, Alexandre Belloni wrote:
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks.

> I think that anyway I'm the only one booting a kernel from after 3.0 on
> the rm9200. I'll test boot that when 4.3-rc1 is released.

What about testing it now on top of clockevents tree which I have
mentioned in the cover letter ?

-- 
viresh
