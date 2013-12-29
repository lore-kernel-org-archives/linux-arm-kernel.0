From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 29 Dec 2013 14:23:39 -0500
Subject: [PATCH v3 3/3] arm: dts: keystone: add keystone timer entry
In-Reply-To: <52BF2164.6040501@linaro.org>
References: <1387974724-31138-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1387974724-31138-4-git-send-email-ivan.khoronzhuk@ti.com>
 <52BC6F28.1020009@ti.com> <52BF2164.6040501@linaro.org>
Message-ID: <52C076BB.7080304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 December 2013 02:07 PM, Daniel Lezcano wrote:
> On 12/26/2013 07:02 PM, Santosh Shilimkar wrote:
>> $subject
>> s/arm/ARM,
>>
>> On Wednesday 25 December 2013 07:32 AM, Ivan Khoronzhuk wrote:
>>> Add keystone timer entry to keystone device tree.
>>> This 64-bit timer is used as backup clock event device.
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>> ---
>> No need to repost. I will fix it up while applying based
>> on state of PATCH 1/3 and 2/3.
> 
> I assume you will take the patchset in your tree.
> 
I wasn't planning to take patch 1/3 and 2/3, assuming
they will go via clocksource tree. Only the dts
$subject patch is what I was planning to pick it up
if the 1/3 and 2/3 gets lined up via thomas's tree.

> I am back from vacations, give me a couple of days to review the patchset before applying it please.
> 
Take your time. Am not applying them as mentioned above.

Regards,
Santosh
