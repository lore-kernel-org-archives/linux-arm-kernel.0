From: horms@verge.net.au (Simon Horman)
Date: Fri, 8 Mar 2013 06:33:54 +0100
Subject: [PATCH] ARM: shmobile: R8A7779: use gic_iid() in SATA IRQ resource
In-Reply-To: <87obeuahg5.wl%kuninori.morimoto.gx@renesas.com>
References: <201303080231.04149.sergei.shtylyov@cogentembedded.com>
 <87obeuahg5.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130308053345.GA771@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 04:00:46PM -0800, Kuninori Morimoto wrote:
> 
> Hi Sergei
> 
> > Commit "ARM: shmobile: r8a7779: use gic_iid macro" switched R8A7779 platform
> > devices to using gic_iid() macro instead of gic_spi() but commit "ARM: mach-
> > shmobile: r8a7779: add SATA support" added another use of gic_spi(). Convert
> > the SATA IRQ resource to using gic_iid().
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have applied this to the soc5 branch and thus queued it
up for v3.10.
