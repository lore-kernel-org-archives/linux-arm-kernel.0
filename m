From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 26 Nov 2012 15:25:42 +0530
Subject: [PATCH] i2c: omap: Remove the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE
 flag
In-Reply-To: <20121126091400.GD15766@arwen.pp.htv.fi>
References: <1353921235-22408-1-git-send-email-shubhrajyoti@ti.com>
 <20121126091400.GD15766@arwen.pp.htv.fi>
Message-ID: <CAM=Q2csBvUxHGTH_CMiZ56tcmHZDRHgTjaEB9=s+RJx-Mwa5pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 2:44 PM, Felipe Balbi <balbi@ti.com> wrote:

> > +     .flags          = OMAP_I2C_FLAG_BUS_SHIFT_2,
>
> if it's not used anymore, how about removing its definition too ?


yes just updated the patch. Thanks.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/0bed79b9/attachment.html>
