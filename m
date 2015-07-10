From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Fri, 10 Jul 2015 18:31:48 +0530
Subject: [PATCH-v3 04/11] i2c: pxa: Remove compile warnning in 64bit mode
In-Reply-To: <20150710081327.GC1528@katana>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-5-git-send-email-vaibhav.hiremath@linaro.org>
 <20150710081327.GC1528@katana>
Message-ID: <559FC23C.1040400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 10 July 2015 01:43 PM, Wolfram Sang wrote:
> On Tue, Jul 07, 2015 at 12:54:48AM +0530, Vaibhav Hiremath wrote:
>> From: Yipeng Yao <ypyao@marvell.com>
>>
>> Fix below warning message, coming from 64 bit toolchain.
>>
>> drivers/i2c/busses/i2c-pxa.c:1237:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>>
>> Signed-off-by: Yipeng Yao <ypyao@marvell.com>
>> [vaibhav.hiremath at linaro.org: Updated Changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Huh? Why long? Shouldn't that be casted to enum pxa_i2c_types?
>

My bad.
Indeed it can be (and should be) enum pxa_i2c_types.

Will wait to close on the discussion on slave mode patch PATCH [02/11]
before pushing V4.


Thanks,
Vaibhav
