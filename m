From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 04 Feb 2013 23:03:41 +0100
Subject: [PATCH 0/3] clock driver for sunxi
In-Reply-To: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <5110303D.3050702@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

Le 22/01/2013 07:12, Emilio L?pez a ?crit :
> This patchset adds basic clock support for sunxi devices. Currently, it
> implements support for the two oscillators, the main PLL, the CPU mux,
> and its three divisor clocks. With this in place, it is possible to
> write a cpufreq driver and have it work.
> 
> I have tested this driver successfully on a Cubieboard (A10, sun4i)
> using the cpufreq driver from the linux-sunxi tree after minor
> modifications (the clock names are not the same).

I just tested this patchset on a A13-Olinuxino, and it looks to be
working fine. I tested without the cpufreq patch though.

Mike, could you give us your feedback on this serie? It would be really
great if we could get this merged by 3.9, if you're ok with it of course.

Thanks,
Maxime
-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
