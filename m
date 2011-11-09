From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2011 15:19:00 -0800
Subject: 3.2-rc1 boot broken on OMAP1 / Amstrad E3
In-Reply-To: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi>
References: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi>
Message-ID: <20111109231900.GS31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [111109 14:19]:
> Hi,
> 
> Has anyone managed to boot 3.2-rc1 on OMAP1?
> 
> On Amstrad E3 it seems to hang at very early on the boot (below
> output is
> with earlyprintk enabled):
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.2.0-rc1-e3 (aaro at dell) (gcc version
> 4.6.1 (GCC) ) #1 PREEMPT Thu Nov 10 00:23:15 EET 2011
> [    0.000000] CPU: ARM925T [54029252] revision 2 (ARMv4T), cr=0000317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine: Amstrad E3 (Delta)
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: ECC disabled, Data cache writethrough
> [    0.000000] OMAP1510
> [    0.000000]  revision 2 handled as 15xx id: bc058c9b93111a16
> 
> Then it prints just some random garbage and hangs.

Hmm looks like it needs a custom map_io, posting a patch just
a sec..

Tony
