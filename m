From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 Mar 2013 12:42:24 +0100
Subject: [PATCH v2 0/3] clock driver for sunxi
In-Reply-To: <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
 <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <513C71A0.3040400@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Le 25/02/2013 15:44, Emilio L?pez a ?crit :
> Hello everyone,
> 
> This patchset adds basic clock support for sunxi devices. Currently, it
> implements support for the two oscillators, the main PLL, the CPU mux,
> its three divisor clocks and APB1. With this in place, it is possible to
> write a cpufreq driver and have it work, and with a little more code,
> represent the UART clocks correctly (I will be sending a separate
> patchset for this).
> 
> I have tested this driver successfully on a Cubieboard (A10, sun4i)
> using the cpufreq driver from the linux-sunxi tree after minor
> modifications (the clock names are not the same).

Could we have your comments or your Acked-by on these patches?

We already missed 3.9 and I'd really want it to have it merged for 3.10,
as it is a real stepping stone for our future work on these SoCs.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
