From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 26 Nov 2012 15:26:45 +0530
Subject: [PATCH] i2c: omap: Remove the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE
 flag
In-Reply-To: <20121126091400.GD15766@arwen.pp.htv.fi>
References: <1353921235-22408-1-git-send-email-shubhrajyoti@ti.com>
 <20121126091400.GD15766@arwen.pp.htv.fi>
Message-ID: <CAM=Q2cszBPhnFwKX2j5DtgOiN1PxT5jApBVUcJohXr1PRckxUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 2:44 PM, Felipe Balbi <balbi@ti.com> wrote:
>
> > -                       OMAP_I2C_FLAG_BUS_SHIFT_2,
> > +     .flags          = OMAP_I2C_FLAG_BUS_SHIFT_2,
>
> if it's not used anymore, how about removing its definition too ?

Just updated the patch , thanks.
