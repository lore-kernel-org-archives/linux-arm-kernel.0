From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 21 Sep 2018 01:01:32 +0200
Subject: [RFC PATCH 0/4] i2c: core: introduce master_xfer_irqless
In-Reply-To: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180920230132.GE988@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 06:14:19PM +0200, Wolfram Sang wrote:
> To keep the discussion about master_xfer_irqless going, I post here a
> draft how I envision the changes to the I2C core. They are only build
> tested. I am unsure if I can test them on hardware before next week, so
> I'll send them around as RFC already, so people can get an idea and
> comment. Maybe Stefan has some bandwidth to test his imx driver
> implementation on top of this?
> 
> A branch can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/xfer_irqless

What I forgot to mention:

At some point, I'd like an adiitional check if the device is flagged to
have very late I2C transfers and trigger a fat warning if not. To keep
bugs visible.

I have ideas but not perfect yet, so I'll leave this as the next step.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/79fdf3e8/attachment.sig>
