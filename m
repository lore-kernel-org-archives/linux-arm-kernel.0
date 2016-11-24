From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Thu, 24 Nov 2016 15:12:15 +0300
Subject: [PATCH 1/9] clocksource/drivers/rockchip_timer: split bc_timer
 into rk_timer and rk_clock_event_device
In-Reply-To: <47746094.VbGlCfGZW0@diego>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
 <47746094.VbGlCfGZW0@diego>
Message-ID: <2217A50B-A694-4304-9628-23C4541FED5A@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko,

> I haven't looked to deep into your patches yet, but what is missing is the 
> general goal of your whole series.


I will be very grateful to receive feedback

> 24 ????. 2016 ?., ? 15:01, Heiko St?bner <heiko@sntech.de> ???????(?):
> 
> git format-patch has this nice "--cover-letter" option that creates obviously 
> a cover-letter where you can describe what your series wants to achieve.
> 
I?ve used --cover-letter option but forget to add message text. Just subject.
So all patches was sent without cover letter. I?ll be careful next time.

> For those reading along, I guess what you want to achieve should be what I 
> describe below, so of course no need to resend just for this :-)
> 
> -----
> The clock supplying the arm-global-timer on the rk3188 is coming from the
> the cpu clock itself and thus changes its rate everytime cpufreq adjusts the 
> cpu frequency making this timer unsuitable as a stable clocksource.
> 
> The rk3188, rk3288 and following socs share a separate timer block already 
> handled by the rockchip-timer driver. Therefore adapt this driver to also be 
> able to act as clocksource on rk3188.
> -----
> 
> Right?

Yes, exactly as you wrote.

Regards,
Alexander.
