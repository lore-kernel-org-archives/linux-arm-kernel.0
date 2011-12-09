From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 9 Dec 2011 12:55:33 +0530
Subject: [PATCH 2/2] regulator: add device tree support for max8997
In-Reply-To: <20111209061720.GF26952@opensource.wolfsonmicro.com>
References: <1323361659-11835-1-git-send-email-thomas.abraham@linaro.org>
 <1323361659-11835-2-git-send-email-thomas.abraham@linaro.org>
 <1323361659-11835-3-git-send-email-thomas.abraham@linaro.org>
 <20111209061720.GF26952@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwSS0-+=D3WbwYDowZQTrFq_s1XEM_gSkgXApstPeGNWkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 December 2011 11:47, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Dec 08, 2011 at 09:57:39PM +0530, Thomas Abraham wrote:
>
>> +Required properties, if interrupts are delivered to host system:
>
> These are just optional properties, really.

Ok. Yeah, these can be classified as optional.

>
>> +- interrupt-parent: Specifies the phandle of the interrupt controller to which
>> + ?the interrupts from max8997 are delivered to.
>> +- interrupts: Interrupt specifiers for two interrupt sources.
>> + ?- First interrupt specifier is for 'irq1' interrupt.
>> + ?- Second interrupt specifier is for 'alert' interrupt.
>
> What if the two are connected to different interrupt controllers?

I have not thought of that. I will try to find out how to write a
device tree node for a device that delivers interrupts to separate
interrupt controllers.

Thanks,
Thomas.

>
>> + ? ?For LDO's:
>
> Extra '.
