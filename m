From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 09:47:31 +0100
Subject: [PATCH 11/19] ARM: ux500: Add all known I2C sub-device nodes to
 the HREF DT
In-Reply-To: <CACRpkdY+t9MwWewtZzpD7i4eeTxVHNk+NxSZ1E=T-k4a0mveHg@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-12-git-send-email-lee.jones@linaro.org>
 <CACRpkdY+t9MwWewtZzpD7i4eeTxVHNk+NxSZ1E=T-k4a0mveHg@mail.gmail.com>
Message-ID: <20120914084729.GG3374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 04:34:15AM -0700, Linus Walleij wrote:
> On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Here we add the skeleton nodes for each of the known I2C sub-devices
> > currently registered on ST-Ericsson's HREF Development Platform. We
> > will fill these nodes in turn as the drivers are enabled for Device
> > Tree.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Can't we have it the other way around (discussing patch ordering
> with Arnd simultaneously), so you first add the DT support to the
> subdevices, then add the more complete nodes to the device tree?
> 
> And if you put in a device tree like this, will these devices
> not collide with the ones that are currently supplied from
> the boardfiles? I'm a bit confused here, maybe I'm not smart
> enough to understand this...

Okay, I've reordered the patch-set to address these possible issues.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
