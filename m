From: horms@verge.net.au (Simon Horman)
Date: Thu, 19 Feb 2015 12:59:09 -0500
Subject: [PATCH v4 0/6] ARM: shmobile: r8a73a4/ape6evm: Complete
 multiplatform support
In-Reply-To: <CAMuHMdWsjWC4k_qp=8nZQj_rAJdUpZMcJjV7uJUePy9G5ij3CA@mail.gmail.com>
References: <1424185486-3017-1-git-send-email-geert+renesas@glider.be>
 <20150218212044.GD12754@verge.net.au>
 <CAMuHMdWsjWC4k_qp=8nZQj_rAJdUpZMcJjV7uJUePy9G5ij3CA@mail.gmail.com>
Message-ID: <20150219175909.GC18262@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 06:44:35PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Feb 18, 2015 at 10:20 PM, Simon Horman <horms@verge.net.au> wrote:
> > With this patch applied I am able to NFS boot the ape6evm using
> > multiplatform using the shmobile_defconfig with CONFIG_MMC disabled.
> >
> > For reference the boot log for shmobile_defconfig (without CONFIG_MMC
> > disabled) is as follows:
> 
> > sh_mmcif ee200000.mmc: Timeout waiting for 1 on CMD0
> 
> I hadn't really planned to do a renesas-drivers release today, but as I can
> reproduce the hang with renesas-devel-20150218-v3.19, but not with my local
> tree, I made a release.
> 
> Shmobile-defconfig from renesas-drivers-2015-02-19-v3.19 boots fine on my
> ape6evm. It seems there are still +100 mmc commits in -next that are not yet
> in upstream.

Thanks, that is good to know.
It seems we may eventually get a working system in mainline :)
