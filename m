From: horms@verge.net.au (Simon Horman)
Date: Tue, 6 Aug 2013 09:38:53 +0900
Subject: [PATCH 0/4] ARM: shmobile: ape6evm: support GPIO switches and LEDs
In-Reply-To: <87zjswsh6p.wl%kuninori.morimoto.gx@renesas.com>
References: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
 <87zjswsh6p.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130806003851.GJ13274@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 12:57:55AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > This short series adds support for GPIO swtiches and LEDS to
> > the ape6evm board.
> > 
> > Applies on top of renesas-devel-20130726.
> > 
> > Simon Horman (4):
> >   ARM: shmobile: ape6evm: support GPIO switches
> >   ARM: shmobile: ape6evm: Enable gpio-keys in defconfig
> >   ARM: shmobile: ape6evm: Add GPIO LEDs
> >   ARM: shmobile: ape6evm: Enable gpio-leds in defconfig
> > 
> >  arch/arm/configs/ape6evm_defconfig     |  6 +++-
> >  arch/arm/mach-shmobile/board-ape6evm.c | 60 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> For all patches
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks.

I have queued up these patches for v3.12.
The two defconfig patches are in the defconfig branch.
And the other two patches are in the boards2 branch.
