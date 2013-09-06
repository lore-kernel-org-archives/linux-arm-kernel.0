From: horms@verge.net.au (Simon Horman)
Date: Fri, 6 Sep 2013 16:09:24 +0900
Subject: [PATCH 00/04] ARM: shmobile: Initial r8a7791 SoC and Koelsch
 board support
In-Reply-To: <20130904083833.GF17329@verge.net.au>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904083833.GF17329@verge.net.au>
Message-ID: <20130906070923.GE1025@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 05:38:35PM +0900, Simon Horman wrote:
> On Wed, Sep 04, 2013 at 12:45:25PM +0900, Magnus Damm wrote:
> > ARM: shmobile: Initial r8a7791 SoC and Koelsch board supp
> > 
> > [PATCH 01/04] ARM: shmobile: Initial r8a7791 SoC support
> > [PATCH 02/04] ARM: shmobile: r8a7791 SCIF support
> > [PATCH 03/04] ARM: shmobile: r8a7791 CMT support
> > [PATCH 04/04] ARM: shmobile: Koelsch support
> > 
> > This series adds initial support for r8a7791 and Koelsch. The SoC
> > is known as r8a7791 which is based on a single cluster Cortex-A15
> > and makes use of SCIF for serial and CMT for timer. Many other
> > on-chip I/O devices are available, and support for those will be
> > added by incremental feature patches.
> > 
> > This initial SoC and board support is providing limited DT-only
> > support and a very basic C-version of board support. In the future
> > improved PINCTRL and clock framework support will be added together
> > with arch timer and SMP support.
> > 
> > Implemented in same style as r8a7790 SoC V1.
> > 
> > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > Signed-off-by: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
> > Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > [damm at opensource.se: forward porting, cleanups, commit logs, CMT support]
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> I have lightly tested these and they seem good to me.
> I have posted a defconfig patch as a follow-up.
> I would to let these sit for a little bit to give them time to
> be reviewed by others.
> 
> Tested-by: Simon Horman <horms+renesas@verge.net.au>

I have queued these up for v3.13.
