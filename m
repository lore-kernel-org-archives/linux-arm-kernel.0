From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 16 Apr 2014 13:01:54 -0400
Subject: [PATCH 1/2] ARM: mvebu: Enable nfsroot in the defconfig
In-Reply-To: <20140416155212.GB1892@arch.cereza>
References: <1396539014-8673-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140416155212.GB1892@arch.cereza>
Message-ID: <20140416170154.GJ28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 12:52:12PM -0300, Ezequiel Garcia wrote:
> Hello guys,
> 
> On Apr 03, Ezequiel Garcia wrote:
> > NFSroot is very frequently used by developers to boot, so let's make
> > our lives simpler and enable it by default.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/configs/mvebu_v7_defconfig | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> 
> Any comments about this two defconfig changes?

Nope.

> After the recent systemd debug mess, now I'm not sure we should add a defconfig,
> just because systemd breaks without it.

If we (mvebu maintainers) don't mind changing the mvebu_*_defconfigs,
who's going to complain?  If it helps your workflow, then we'll add it.

My only issue would be if the change breaks the bootfarm testing.

The debug thread and this series are completely orthogonal.

thx,

Jason.
