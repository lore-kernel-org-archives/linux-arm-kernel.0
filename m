From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 10 Jun 2014 13:04:40 -0400
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
References: <20140328184517.GA27219@cbox>
 <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
Message-ID: <53973AA8.9020301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 06/10/2014 10:42 AM, Peter Maydell wrote:
> On 28 March 2014 18:45, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> ARM VM System Specification
>> ===========================
>>
> 
>> The virtual hardware platform must provide a number of mandatory
>> peripherals:
>>
>>   Serial console:  The platform should provide a console,
>>   based on an emulated pl011, a virtio-console, or a Xen PV console.
>>
>>   An ARM Generic Interrupt Controller v2 (GICv2) [3] or newer.  GICv2
>>   limits the the number of virtual CPUs to 8 cores, newer GIC versions
>>   removes this limitation.
>>
>>   The ARM virtual timer and counter should be available to the VM as
>>   per the ARM Generic Timers specification in the ARM ARM [1].
> 
> I just noticed that this doesn't mandate that the platform
> provides an RTC. As I understand it, the UEFI spec mandates
> that there's an RTC (could somebody more familiar with UEFI
> than me confirm/deny that?) so we should probably put one here.

Pardon my ignorance, but what exactly disqualifies Generic Timer
implementations from being used as Real Time Clocks?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
