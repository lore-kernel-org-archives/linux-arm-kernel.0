From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Nov 2014 16:10:11 +0100
Subject: [PATCH 05/12] soc/tegra: Add efuse driver for Tegra
In-Reply-To: <20141019031241.GA18880@tiger>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <1405080971-7609-6-git-send-email-thierry.reding@gmail.com>
 <20141019031241.GA18880@tiger>
Message-ID: <20141110151009.GA13447@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 19, 2014 at 11:12:45AM +0800, Shawn Guo wrote:
> On Fri, Jul 11, 2014 at 02:16:04PM +0200, Thierry Reding wrote:
> > diff --git a/drivers/misc/fuse/Makefile b/drivers/misc/fuse/Makefile
> > new file mode 100644
> > index 000000000000..0679c4febc89
> > --- /dev/null
> > +++ b/drivers/misc/fuse/Makefile
> > @@ -0,0 +1 @@
> > +obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
> 
> I just happened to notice this change on linux-next introduced by this
> patch?  It's a leftover from early version of the patch, I guess?

Indeed so. I've sent out a patch to fix this.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/842be9cd/attachment.sig>
