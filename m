From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 28 Oct 2018 22:34:50 +0000
Subject: [PATCH v2 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
In-Reply-To: <09a6b1d4-f8f4-ea90-f361-bd3a92088430@ti.com>
References: <20180928052557.21663-1-vigneshr@ti.com>
 <09a6b1d4-f8f4-ea90-f361-bd3a92088430@ti.com>
Message-ID: <20181028223450.GK1882@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 20, 2018 at 01:23:40PM +0530, Vignesh R wrote:
> 
> 
> On 28-Sep-18 10:55 AM, Vignesh R wrote:
> > Couple of patches to enable i2c-omap driver to be used with TI's new
> > AM654 platforms.
> > 
> > 
> > Vignesh R (2):
> >   dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
> >   i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3
> > 
> >  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
> >  drivers/i2c/busses/Kconfig                         | 2 +-
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> > 
> 
> Gentle ping...

Maintainer tags are missing. Tony is listed for this driver on OMAP2+.
Is this his realm? Do we need a specific maintainer for this driver?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181028/a78e623f/attachment-0001.sig>
