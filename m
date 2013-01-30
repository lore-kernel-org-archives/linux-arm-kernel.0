From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Jan 2013 09:17:25 +0100
Subject: [PATCH 0/3] clock driver for sunxi
In-Reply-To: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <5108D715.3080403@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

Le 22/01/2013 07:12, Emilio L?pez a ?crit :
> Hello everyone,
> 
> This patchset adds basic clock support for sunxi devices. Currently, it
> implements support for the two oscillators, the main PLL, the CPU mux,
> and its three divisor clocks. With this in place, it is possible to
> write a cpufreq driver and have it work.
> 
> I have tested this driver successfully on a Cubieboard (A10, sun4i)
> using the cpufreq driver from the linux-sunxi tree after minor
> modifications (the clock names are not the same).

Thanks for doing this. I'll try to test it on my boards this week.

I don't have a lot of comments, but Mike will probably have some.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
