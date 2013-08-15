From: jic23@kernel.org (Jonathan Cameron)
Date: Thu, 15 Aug 2013 12:03:02 +0100
Subject: [PATCH v8 0/2] TWL6030, TWL6032 GPADC driver
In-Reply-To: <20130815091216.GB28366@e106331-lin.cambridge.arm.com>
References: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
 <20130815091216.GB28366@e106331-lin.cambridge.arm.com>
Message-ID: <520CB566.2050201@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> The changes to the original driver:
>> - device tree adaptation;
> 
> I couldn't see a binding document in this series or in mainline. Have I
> looked in the wrong places?

Nothing explicit supplied, but does it need one given it is doing only
iio bindings (bindings/iio/iio-bindings.txt)
plus twl child bindings
(bindings/mfd/twl-family.txt)

If it does, I guess absolutely everything does, then fair enough!
I guess that would make sense as there is no way for someone writing
a device tree to know that there is nothing else to be specified.

Thanks,

Jonathan
