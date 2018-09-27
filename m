From: tony@atomide.com (Tony Lindgren)
Date: Thu, 27 Sep 2018 07:53:32 -0700
Subject: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
In-Reply-To: <305bf1c3-915d-dac1-95e4-4d32621247e1@ti.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
 <20180925144021.GN5662@atomide.com>
 <20180925175537.GQ5662@atomide.com>
 <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
 <20180926155911.GT5662@atomide.com>
 <20180926162303.GU5662@atomide.com>
 <cfc3f1db-9468-ed92-a673-882b51b4dec8@ti.com>
 <20180926233111.GY5662@atomide.com>
 <305bf1c3-915d-dac1-95e4-4d32621247e1@ti.com>
Message-ID: <20180927145332.GA5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180927 05:00]:
> On Thursday 27 September 2018 05:01 AM, Tony Lindgren wrote:
> > The following works for me, does it look OK to you?
> 
> This works pretty well with DS0 on am437x-gp-evm. Tested rtc wakeup,
> wakeup using uart and touch. All of the work well.
> 
> https://pastebin.ubuntu.com/p/RJhJJKhJHX/

OK good to hear and thanks for testing again.

> Also tested on beaglebone black DS0 works fine. Although there seems to
> be an additional warning which was not seen before:
> 
> "l4-wkup-clkctrl:0008:0: failed to disable"
> 
> log: https://pastebin.ubuntu.com/p/Ns2WRdVkXS/
> 
> Also the above warning is present without/with this patch on [0].
> No such warnings on am4 though.

OK. For am335x I'll post an updated version of the am335x
changes to fix the gpio dbck offset.

Regards,

Tony

> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v4.20/dt-ti-sysc-tmp-testing
