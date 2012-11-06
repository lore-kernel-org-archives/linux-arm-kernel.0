From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Nov 2012 09:38:48 +0100
Subject: [PATCH 6/8] mfd/ab8500-core: use irq_domain_add_simple()
In-Reply-To: <20121105225922.GF7965@sortiz-mobl>
References: <1350580755-8516-1-git-send-email-linus.walleij@stericsson.com>
 <20121105225922.GF7965@sortiz-mobl>
Message-ID: <CACRpkdbJPrBc8suMzoG-4ZDxL18Hdb7i=P9vVcKih7u=Lf9kTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2012 at 11:59 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> On Thu, Oct 18, 2012 at 07:19:15PM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> To be able to use SPARSE_IRQ while yet not using device tree,
>> we need to use irq_domain_add_simple() that will allocate
>> descriptors for the IRQs in the non-DT case, and fall back
>> to using the linear irqdomain in the DT case.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> In case it's not too late:
>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Too late for my pull request to ARM SoC, but the important
thing is that the ARM SoC people see that you're OK with it
so they can pull in my patches :-)

Thanks Sam!

Yours,
Linus Walleij
