From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 05 Aug 2015 19:54:33 +0530
Subject: [PATCH-v5 1/5] Documentation: binding: add new property
 'disable_after_xfer' to i2c-pxa
In-Reply-To: <20150805142011.GC23173@beef>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437482466-16126-2-git-send-email-vaibhav.hiremath@linaro.org>
 <20150727140911.GB15004@beef> <55C1AE71.3010700@linaro.org>
 <20150805142011.GC23173@beef>
Message-ID: <55C21CA1.9040108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 05 August 2015 07:50 PM, Matt Porter wrote:
> On Wed, Aug 05, 2015 at 12:04:25PM +0530, Vaibhav Hiremath wrote:
>>
>>
>> On Monday 27 July 2015 07:39 PM, Matt Porter wrote:
>>> On Tue, Jul 21, 2015 at 06:11:02PM +0530, Vaibhav Hiremath wrote:
>>>> Driver will now supports enable/disable across msg xfer, which user
>>>> can control it by new DT property -
>>>>
>>>> i2c-disable-after-xfer : If set, driver will disable I2C module after msg
>>>>   xfer and enable it back before xfer.
>>>
>>> If this is a new property specific to this Marvell part, it needs
>>> the vendor prefix as in mrvl,i2c-disable-after-xfer
>>>
>>
>> We discussed about this, I think in V1 or V2. Decided to use generic
>> name, as feature (in turn property) could be used by other drivers as
>> well.
>
> Ahh, ok, thanks...coming in too late on this one. :)
>
>>> Or, it couldn't hurt to start an i2c.txt for generic i2c bindings
>>> and store it there as this and others later in this series would
>>> reasonably apply to other controllers.
>>>
>>
>> Yeah, we could start i2c.txt, probably better to have separate new
>> patch all together.
>
> Great, yes, I've always found it hard to follow i2c generic bindings
> since they aren't defined in a clear place like other similar hardware
> (e.g. SPI).
>

Wolfram has already owned up on creating i2c.txt for generic properties.
So, we will be soon close to others.

And thanks for your comments.
Please let me know if you have any other comments on patch-series, so
that I can incorporate it in next version.

Thanks,
Vaibhav
