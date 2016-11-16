From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Nov 2016 20:59:51 -0200
Subject: Boot failures in -next due to 'ARM: dts: imx: Remove
 skeleton.dtsi'
In-Reply-To: <20161116224024.GA11821@roeck-us.net>
References: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
 <20161116184649.GF11228@leverpostej> <20161116221002.GA19925@roeck-us.net>
 <CAOMZO5Bd2X3pVqExBtBw_uHReDDkf6J2VdMXnAXynCAHxoX60A@mail.gmail.com>
 <20161116224024.GA11821@roeck-us.net>
Message-ID: <CAOMZO5AXP8hi6t9-rfdG7daiFFsa8oJ70cF9fbZuoWnx8t+vLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 8:40 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> Yes, but not the 'device_type' property, which the kernel seems to expect.
> The qemu patch below fixes the problem for sabrelite, I just don't know
> if that is really the way to go. You tell me; I'll be happy to submit
> the necessary patch(es) into qemu.

I can send the patch adding device_type for the i.MX dts files, but in
the meantime, it would be nice if you could send your proposal patch
to qemu as it will make qemu to work closer to the real hardware.

Thanks

> The same is true for 'chosen'. Right now qemu expects this node to exist.
> It does exist for sabrelite, but apparently not for imx25-pdk.

We can fix this too in the dts.

Thanks
