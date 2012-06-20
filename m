From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 14:00:02 +0100
Subject: [PATCH 08/14] mfd: Add IRQ domain support for the AB8500
In-Reply-To: <20120618185638.GY3974@opensource.wolfsonmicro.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-9-git-send-email-lee.jones@linaro.org>
 <20120614183231.GA30185@sirena.org.uk> <4FDEEEBD.5070108@linaro.org>
 <20120618102003.GB12029@n2100.arm.linux.org.uk>
 <20120618185638.GY3974@opensource.wolfsonmicro.com>
Message-ID: <4FE1C952.5000306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/06/12 19:56, Mark Brown wrote:
> On Mon, Jun 18, 2012 at 11:20:03AM +0100, Russell King - ARM Linux wrote:
>
>>> +	int offset = data->irq;
>
>> Are you sure this is right?  I thought irq_data->irq was the Linux IRQ
>> number, irq_data->hwirq was the interrupt number inside the domain.

Thanks. Good catch. I have just sent a new patch-set to the mailing list 
where I have sent the fixed- up patch again.

> Yes, that's correct.  I'm surprised the code runs without crashing...

Oddly the code ran perfectly.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
