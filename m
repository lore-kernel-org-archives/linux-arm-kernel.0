From: greg@kroah.com (Greg KH)
Date: Wed, 31 Oct 2012 09:16:14 -0700
Subject: linux-next: manual merge of the arm-soc tree with the staging tree
In-Reply-To: <20121031161921.3c9a46bd03f5864eed88fc87@canb.auug.org.au>
References: <20121031161921.3c9a46bd03f5864eed88fc87@canb.auug.org.au>
Message-ID: <20121031161614.GF31804@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 04:19:21PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-omap2/drm.c between commit 5e3b08749951 ("staging:
> drm/omap: add support for ARCH_MULTIPLATFORM") from the staging tree and
> commit 2a296c8f89bc ("ARM: OMAP: Make plat/omap_hwmod.h local to
> mach-omap2") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Looks good to me, thanks for this.

greg k-h
