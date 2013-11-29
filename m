From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 14:33:46 +0100
Subject: [PATCH 08/31] pci: tegra: use reset framework
In-Reply-To: <20131129132957.GU22771@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-9-git-send-email-swarren@wwwdotorg.org>
 <20131129132957.GU22771@ulmo.nvidia.com>
Message-ID: <20131129133345.GV22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 02:29:58PM +0100, Thierry Reding wrote:
> On Fri, Nov 15, 2013 at 01:54:03PM -0700, Stephen Warren wrote:
> [...]
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > index 0afbbbc55c81..174a5bc2d993 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/pci.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/reset.h>
> 
> Can't you also remove the linux/clk/tegra.h include now that none of the
> functions it declares are used anymore?
> 
> Otherwise looks good to me:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>

And I guess also:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/3b1dd82e/attachment.sig>
