From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 Feb 2013 22:15:50 +0900
Subject: [PATCH 5/9] ARM: shmobile: mark mackerel sh_mmcif_device
 __maybe_unused
In-Reply-To: <201302151255.06547.arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
 <1360880818-4071454-6-git-send-email-arnd@arndb.de>
 <20130214232426.GB30667@verge.net.au>
 <201302151255.06547.arnd@arndb.de>
Message-ID: <20130215131550.GB27724@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 12:55:06PM +0000, Arnd Bergmann wrote:
> On Thursday 14 February 2013, Simon Horman wrote:
> > On Thu, Feb 14, 2013 at 11:26:54PM +0100, Arnd Bergmann wrote:
> > > Patch eac036ef9e "ARM: shmobile: streamline mackerel SD and MMC devices"
> > > made the use of the sh_mmcif_device variable for mackarel optional,
> > > but the definition is always provided, causing a build warning.
> > > 
> > > arch/arm/mach-shmobile/board-mackerel.c:1120:31: warning: 'sh_mmcif_device'
> > > 	defined but not used [-Wunused-variable]
> > > 
> > > Marking the variable as __maybe_unused will do the right thing here.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > Cc: Simon Horman <horms+renesas@verge.net.au>
> > 
> > No objections here.
> > 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> AFAICT, the change that caused this is in linux-next only through your
> heads/boards3 branch but not through arm-soc, so please apply my patch
> on your branch.

Sure, will do.
