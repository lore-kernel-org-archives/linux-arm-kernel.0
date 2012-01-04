From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 04 Jan 2012 10:20:28 +0100
Subject: [GIT PULL v2] at91: devices and boards files update for 3.3
In-Reply-To: <201201032139.21163.arnd@arndb.de>
References: <4EEA034C.9020800@atmel.com> <4F02E1B9.30009@atmel.com>
 <201201032139.21163.arnd@arndb.de>
Message-ID: <4F0419DC.6050100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2012 10:39 PM, Arnd Bergmann :
> On Tuesday 03 January 2012, Nicolas Ferre wrote:
>> Arnd, Olof,
>>
>> According to our discussion with Olof and Guennadi, I rebased this pull request
>> on top of V4L git tree:
>> git://linuxtv.org/gliakhovetski/v4l-dvb.git for-3.3
>> (v3.2-rc2-262-g7a13e73 today)
>>
>> This pull request adds some bits to at91 devices and board files. The ISI driver
>> is the biggest part and does not have DT support. As ISI has been waited for a 
>> long time on AT91, I think it is not possible to wait for the DT support. Moreover, 
>> DT support for this camera sensor + ISI soc interface seems not so trivial and 
>> will certainly need a handful of kernel releases before being stabilized.
>>
>> The following changes since commit 7a13e733707d9cc1225ba07274360da2be9984cb:
>>
>>   media i.MX27 camera: Fix field_count handling. (2011-12-29 09:20:04 +0100)
>>
>> are available in the git repository at:
>>   git://github.com/at91linux/linux-at91.git for-arnd-3.3-device_boardV2
> 
> Hi Nicolas,
> 
> Looks all good to me. I've pulled it into the next/drivers2 branch even though
> your patches are not really all driver specific. However, the drivers2 branch
> already holds some samsung changes that have dependencies on external branches,
> so I can nicely group these together.
> 
> How we end up submitting these will depend on the timing of dependencies during
> the merge window.

Ok, very nice. I will keep monitoring it also.

Thanks a lot, best regards,
-- 
Nicolas Ferre
