From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Dec 2015 14:12:44 +0900
Subject: [PATCH 2/3] arm64: dts: r8a7795: Add Cortex-A57 CPU cores
In-Reply-To: <20151211230751.GD6496@verge.net.au>
References: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
 <1449236333-4410-2-git-send-email-dirk.behme@gmail.com>
 <20151211230751.GD6496@verge.net.au>
Message-ID: <20151215051243.GA29362@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2015 at 08:07:51AM +0900, Simon Horman wrote:
> On Fri, Dec 04, 2015 at 02:38:52PM +0100, Dirk Behme wrote:
> > From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> > 
> > Add Cortex-A57 CPU cores to r8a7795 SoC for a total of 4 x Cortex-A57.
> > 
> > Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Sigend-off-by: Dirk Behme <dirk.behme@gmail.com>
> 
> Thanks, I have queued this up for v4.5.

I meant to test this earlier but somehow it slopped my mind.

With this patch applied I still only see one CPU brought up
whereas I was expecting 4. Are more patches needed in order to
get more CPUs operating?

I am using renesas-devel-20151214-v4.4-rc5 + the cpg-mmsr driver (v6).
I built the kernel using the defconfig.
