From: jic23@kernel.org (Jonathan Cameron)
Date: Thu, 15 Aug 2013 18:59:08 +0100
Subject: [PATCH v8 0/2] TWL6030, TWL6032 GPADC driver
In-Reply-To: <20130815125906.GA32421@e106331-lin.cambridge.arm.com>
References: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
 <20130815091216.GB28366@e106331-lin.cambridge.arm.com>
 <520CB566.2050201@kernel.org>
 <20130815125906.GA32421@e106331-lin.cambridge.arm.com>
Message-ID: <520D16EC.90604@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/13 13:59, Mark Rutland wrote:
> On Thu, Aug 15, 2013 at 12:03:02PM +0100, Jonathan Cameron wrote:
>>
>>>> The changes to the original driver:
>>>> - device tree adaptation;
>>>
>>> I couldn't see a binding document in this series or in mainline. Have I
>>> looked in the wrong places?
>>
>> Nothing explicit supplied, but does it need one given it is doing only
>> iio bindings (bindings/iio/iio-bindings.txt)
>> plus twl child bindings
>> (bindings/mfd/twl-family.txt)
> 
> Every binding needs to be documented.
> 
>>
>> If it does, I guess absolutely everything does, then fair enough!
>> I guess that would make sense as there is no way for someone writing
>> a device tree to know that there is nothing else to be specified.
> 
> Yup, that's why. Also, Linux isn't necessarily the only consumer, and
> other consumers shouldn't need to read Linux code to figure out how a
> particular binding is supposed to look.
> 
Fair enough. Thanks for clearing that up.

Oleksandr, could you send a follow up patch adding the required documentation?
(mostly a cut and paste job from similar elements by the look of it).

Thanks

Jonathan

> Cheers,
> Mark.
> 
