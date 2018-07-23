From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Jul 2018 13:17:46 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.19
In-Reply-To: <20180721220343.yuwrfxz3fo25krzv@localhost>
References: <cover.1532086504.git.horms+renesas@verge.net.au>
 <20180721220343.yuwrfxz3fo25krzv@localhost>
Message-ID: <20180723111746.hncgzsupudunmbzy@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 03:03:43PM -0700, Olof Johansson wrote:
> On Fri, Jul 20, 2018 at 02:03:54PM +0200, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC defconfig updates for v4.19.
> > 
> > 
> > The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> > 
> >   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> > 
> > are available in the git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-defconfig-for-v4.19
> > 
> > for you to fetch changes up to e82c98d0448c60706a8024d460eadb9d7402dcba:
> > 
> >   ARM: multi_v7_defconfig: Enable support for RZN1D-DB (2018-07-13 10:15:20 +0200)
> > 
> > ----------------------------------------------------------------
> > Renesas ARM Based SoC Defconfig Updates for v4.19
> > 
> > multi_v7_defconfig and shmobile_defconfig Enhancement:
> > 
> > * Enable support for recently upstreamed RZN1D-DB board
> >   in multi_v7_defconfig and shmobile_defconfig. This is
> >   to give better test coverage.
> > 
> > shmobile_defconfig Clean-Up:
> > 
> > * Drop NET_VENDOR_<FOO>=n
> > 
> >   This reduces the size of the defconfig without any change in the
> >   resulting kernel config.
> > 
> > shmobile_defconfig Enhancements:
> > 
> > * Set CONFIG_LOCALVERSION to shmobile_defconfig
> > 
> >   This follows what appears to be common practice in defconfigs
> >   and allows easier management of the kernel flavour at run-time.
> 
> I replied to the multi-versions of defconfig for this patch -- it's not a good
> way to solve the problem of detecting config at runtime. Please drop this
> patch. See:
> 
> https://lore.kernel.org/lkml/CAOesGMgkU6yBRpAsED2fPyuAo9Tc=YprndGdkmBVrc+0783VwQ at mail.gmail.com/

Thanks, I'll repost this pull-request with that patch dropped.
