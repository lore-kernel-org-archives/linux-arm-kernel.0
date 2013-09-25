From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 25 Sep 2013 13:51:59 -0400
Subject: [PATCH 0/3 v2] clk: keystone: Add common clock drivers
In-Reply-To: <CAPtuhTg1z29+L8jjY4+putq6_-yX4G12UgMm7K3PnD4q5KZVjA@mail.gmail.com>
References: <1377803662-3509-1-git-send-email-santosh.shilimkar@ti.com>
 <52430B96.5070702@ti.com>
 <CAPtuhTg1z29+L8jjY4+putq6_-yX4G12UgMm7K3PnD4q5KZVjA@mail.gmail.com>
Message-ID: <524322BF.5000407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 September 2013 01:50 PM, Mike Turquette wrote:
> On Wed, Sep 25, 2013 at 9:13 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Mike,
>>
>> On Thursday 29 August 2013 03:14 PM, Santosh Shilimkar wrote:
>>> v2:
>>> - Aligned the bindings as per the list discussion. Removed the additional
>>>       parameters by usage of reg-names and additional compatible fields.
>>> - Addressed all the comments from v1 on drivers.
>>> - Split the series into clock drivers($subject series) and
>>>       platform, dt updates. Will post that one separately.
>>>
>>> Special thanks to Mike and Mark for the detailed review on v1.
>>>
>>> Series is an attempt to add the clock drivers for Keystone SOCs
>>> based on common clock framework. A PLL drivers taking care of
>>> SOC PLLs and a gate control driver taking clock management for
>>> the IPs. The current Keystone based SOCs don' support dynamic power
>>> management usecases like DVFS, SOC ilde etc and hence most of the
>>> usage is limited to enabling clocks and finding the current clock
>>> rate etc.
>>>
>>> Based on to of Mike's dt binding series [1] and tested on Keystone2
>>> EVM.
>>>
>>> Cc: Mike Turquette <mturquette@linaro.org>
>>
>> As aligned off-list, I will revise the series to remove the
>> dependency with your DT bindings series which still seems to
>> be under discussion.
> 
> ACK. I plan to refresh my DT bindings and make them more concise, but
> I still think it is wise if you do not rely on them. As we discussed
> you can switch over to those bindings at any point in the future if
> you wish.
> 
Sounds good.

Regards,
Santosh
