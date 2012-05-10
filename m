From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 May 2012 14:27:45 +0200
Subject: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core
 driver
In-Reply-To: <20120510102657.GD3190@n2100.arm.linux.org.uk>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-12-git-send-email-lee.jones@linaro.org>
 <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
 <20120510102657.GD3190@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaiGUoK+TaPaObBbTQH0BgPFXr2F2PTHO5GsUE0Prc32w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 12:26 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, May 09, 2012 at 11:02:27AM +0200, Linus Walleij wrote:

>> Shouldn't this be (av8500->irq_base == NO_IRQ) now that we're tranisitioning to
>> use 0 as NO_IRQ?
>
> No it shouldn't. ?We want new drivers to be rejecting on explicitly zero
> IRQ numbers and not using NO_IRQ at all. ?We want to get rid of NO_IRQ
> entirely.

Yes of course, it's strange how I can go astray sometimes ..
(!av8500->irq_base) it is.

Thanks Russell,
Linus Walleij
