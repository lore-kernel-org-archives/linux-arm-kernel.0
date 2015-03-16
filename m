From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 16 Mar 2015 14:18:27 -0700
Subject: [PATCH] ARM: amba: Increase number of IRQs
In-Reply-To: <20150316210817.GQ8656@n2100.arm.linux.org.uk>
References: <sbranden@broadcom.com>
 <1426529962-2204-1-git-send-email-sbranden@broadcom.com>
 <20150316210817.GQ8656@n2100.arm.linux.org.uk>
Message-ID: <550748A3.7030900@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 15-03-16 02:08 PM, Russell King - ARM Linux wrote:
> On Mon, Mar 16, 2015 at 11:19:22AM -0700, Scott Branden wrote:
>> The current AMBA bus only allows up to 9 IRQs per device. This is
>> incorrect, as in peripherals like PL330 can have up to 32 IRQs.
>> Increase AMBA_NR_IRQS from 9 to 32.
>
> I'm quite certain that 32 will also be "incorrect" at some point in the
> future, so let's not use such language.  Let's make this more neutral
> and say "This does not suit peripherals like the PL330 which can have
> up to 32 IRQs."

OK, I sent out a new patch with update commit message.

Thanks,
  Scott

>
> Thanks.
>
