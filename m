From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 7 May 2015 09:27:00 +0100
Subject: [PATCH v7 0/3] ARM: mediatek: Add driver for Mediatek I2C
In-Reply-To: <1430985284.22615.3.camel@mtksdaap41>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
 <20150507073900.GC12484@x1> <1430985284.22615.3.camel@mtksdaap41>
Message-ID: <20150507082700.GE12484@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 May 2015, Eddie Huang wrote:
> On Thu, 2015-05-07 at 08:39 +0100, Lee Jones wrote:
> > On Wed, 06 May 2015, Eddie Huang wrote:
> > 
> > > 
> > > Eddie Huang (1):
> > >   I2C: mediatek: Add driver for MediaTek MT8173 I2C controller
> > > 
> > > Xudong Chen (2):
> > >   dt-bindings: Add I2C bindings for mt65xx/mt81xx.
> > >   I2C: mediatek: Add driver for MediaTek I2C controller
> > > 
> > >  .../devicetree/bindings/i2c/i2c-mt6577.txt         |  41 ++
> > >  drivers/i2c/busses/Kconfig                         |   9 +
> > >  drivers/i2c/busses/Makefile                        |   1 +
> > >  drivers/i2c/busses/i2c-mt65xx.c                    | 748 +++++++++++++++++++++
> > >  4 files changed, 799 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> > >  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
> > 
> > Again, you've sent me a patch-set that has absolutely nothing to do
> > with me.  Can you please stop doing that, my inbox is full enough
> > already!
> > 
> 
> Sorry, I use "scripts/get_maintainer.pl" to get mail receiver, and you
> are on list.

Yes, the "Commit Signer" entry is the bane of my life.  It's best not
to Cc everyone who has every touched a file in a given subsystem.

> I will narrow down receiver next time.

Thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
