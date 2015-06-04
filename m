From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 5 Jun 2015 00:17:56 +0200
Subject: [PATCH 1/2] rtc: mxc: add a second clock
In-Reply-To: <5570BE33.9080103@gmail.com>
References: <1431729330-7625-1-git-send-email-tremyfr@gmail.com>
 <1431729330-7625-2-git-send-email-tremyfr@gmail.com>
 <20150528115731.GN2185@piout.net> <5570BE33.9080103@gmail.com>
Message-ID: <20150604221756.GD713@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2015 at 23:08:03 +0200, Philippe Reynes wrote :
> >You are getting the rate but don't you need to clk_prepare_enable()?
> 
> This IP needs the clock reference rate for his configuration,
> so I think that I only need the rate.
> 

I think we need to check whether we are guaranteed to get a result from
get_rate even if the clock is not enabled.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
