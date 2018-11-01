From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Nov 2018 22:36:38 +0100
Subject: [PATCH] RFC: ARM: do not handle Spectre V2 on Vexpress CA9
In-Reply-To: <20181101172512.GP30658@n2100.armlinux.org.uk>
References: <20181101125406.8874-1-linus.walleij@linaro.org>
 <42704270-8d9f-3f7a-9af1-4bd87f413815@arm.com>
 <20181101172512.GP30658@n2100.armlinux.org.uk>
Message-ID: <CACRpkdZ9CKssFR3kT_rkFLeG7eJM95zZJ0GfT7vz488i51_Vtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 6:25 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> The platform is basically unreliable - it's not called a "test chip"
> for no reason!

I think you're right. Since I have qemu working for it, I just stick
with that in my development for now, and do the odd test on hardware
on the days it happens to be working. I guess this patch doesn't
help in general, it just helped today.

Yours,
Linus Walleij
