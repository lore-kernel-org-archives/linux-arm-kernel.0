From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2018 15:02:03 -0700
Subject: [RFC PATCH 0/4] i2c: core: introduce master_xfer_irqless
In-Reply-To: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180920220203.GA5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wolfram Sang <wsa+renesas@sang-engineering.com> [180920 09:19]:
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
> 
> Happy hacking and thanks for all the input to this,

Thanks looks nice to me:

Acked-by: Tony Lindgren <tony@atomide.com>
