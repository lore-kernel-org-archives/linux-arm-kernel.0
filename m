From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 22 Mar 2013 09:40:54 -0700
Subject: [PATCH v2 0/3] clock driver for sunxi
In-Reply-To: <514C30E1.2020203@free-electrons.com>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
 <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
 <20130321215429.834.60042@quantum> <514C30E1.2020203@free-electrons.com>
Message-ID: <20130322164054.834.64867@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2013-03-22 03:22:25)
> Hi Mike,
> 
> Le 21/03/2013 22:54, Mike Turquette a ?crit :
> > Quoting Emilio L?pez (2013-02-25 06:44:25)
> >> Hello everyone,
> >>
> >> This patchset adds basic clock support for sunxi devices. Currently, it
> >> implements support for the two oscillators, the main PLL, the CPU mux,
> >> its three divisor clocks and APB1. With this in place, it is possible to
> >> write a cpufreq driver and have it work, and with a little more code,
> >> represent the UART clocks correctly (I will be sending a separate
> >> patchset for this).
> >>
> >> I have tested this driver successfully on a Cubieboard (A10, sun4i)
> >> using the cpufreq driver from the linux-sunxi tree after minor
> >> modifications (the clock names are not the same).
> >>
> >> Any feedback will be highly appreciated
> >>
> > 
> > Emilio,
> > 
> > This is a nice series.  I appreciate the amount of comments in the code,
> > the kerneldoc and also the added sunxi clock documentation.
> > 
> > Concerning the discussion from the v1 series, I prefer for the struct
> > clk instances in the tree to match 1-to-1 with hardware clocks.  As the
> > number of clocks in a system scales into the hundreds there are
> > certainly advantages to having fewer clocks in the hierarchy, not the
> > least of which is more easily associating these objects with hardware
> > clocks during a deep debug session.
> > 
> > That can be changed at a later time if you wish.  Do you want me to take
> > the series into clk-next or do you just want my ack?
> 
> Thanks for your feedback!
> 
> Unless you have some objection, I was planning to merge it through my
> tree, with your Acked-by, of course.
> 

Acked-by: Mike Turquette <mturquette@linaro.org>

> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
