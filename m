From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 04:34:15 -0700
Subject: [PATCH 11/19] ARM: ux500: Add all known I2C sub-device nodes to
 the HREF DT
In-Reply-To: <1347016499-29354-12-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-12-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY+t9MwWewtZzpD7i4eeTxVHNk+NxSZ1E=T-k4a0mveHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we add the skeleton nodes for each of the known I2C sub-devices
> currently registered on ST-Ericsson's HREF Development Platform. We
> will fill these nodes in turn as the drivers are enabled for Device
> Tree.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Can't we have it the other way around (discussing patch ordering
with Arnd simultaneously), so you first add the DT support to the
subdevices, then add the more complete nodes to the device tree?

And if you put in a device tree like this, will these devices
not collide with the ones that are currently supplied from
the boardfiles? I'm a bit confused here, maybe I'm not smart
enough to understand this...

Yours,
Linus Walleij
