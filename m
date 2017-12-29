From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Fri, 29 Dec 2017 11:52:38 +0300
Subject: [PATCH 1/2] clk: rename clk_core_get_boundaries() to
 clk_hw_get_boundaries() and expose
In-Reply-To: <20171229001417.GC7997@codeaurora.org>
References: <1513872282-5370-1-git-send-email-al.kochet@gmail.com>
 <1513872282-5370-2-git-send-email-al.kochet@gmail.com>
 <20171221200743.GM7997@codeaurora.org>
 <8EC4D15B-4A89-43FA-953E-95AF81417067@gmail.com>
 <20171227010638.GP7997@codeaurora.org>
 <4B1BB338-F1F9-4231-BDCA-5FBB1F61BC44@gmail.com>
 <20171229001417.GC7997@codeaurora.org>
Message-ID: <C7AA677C-664F-4305-B74D-B13F3FF0A199@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 29 ???. 2017 ?., ? 3:14, Stephen Boyd <sboyd@codeaurora.org> ???????(?):
> 
> I'm asking if the rate is capped on the consumer side with
> clk_set_max_rate() or if it's capped on the clk provider side to
> express a hardware constraint.
I do that using clk_set_max_rate() at provider size inside clk-rk3188.c.

> 
> Sounds like there are some things to be figured out here still. I
> can take a closer look next week. Maybe Heiko will respond before
> then.

I will be very grateful for the ideas. I can continue to work on this next
week too.

Happy New Year and Merry Christmas!

Regards,
Alexander.
