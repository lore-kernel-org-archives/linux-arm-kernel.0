From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 13 Jan 2014 14:14:33 +0100
Subject: [PATCH v3 3/3] arm: dts: keystone: add keystone timer entry
In-Reply-To: <52D3CDD5.9060104@ti.com>
References: <1387974724-31138-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1387974724-31138-4-git-send-email-ivan.khoronzhuk@ti.com>
 <52BC6F28.1020009@ti.com> <52BF2164.6040501@linaro.org>
 <52D3CDD5.9060104@ti.com>
Message-ID: <52D3E6B9.40502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2014 12:28 PM, ivan.khoronzhuk wrote:
> On 12/28/2013 09:07 PM, Daniel Lezcano wrote:
>> On 12/26/2013 07:02 PM, Santosh Shilimkar wrote:
>>> $subject
>>> s/arm/ARM,
>>>
>>> On Wednesday 25 December 2013 07:32 AM, Ivan Khoronzhuk wrote:
>>>> Add keystone timer entry to keystone device tree.
>>>> This 64-bit timer is used as backup clock event device.
>>>>
>>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>>> ---
>>> No need to repost. I will fix it up while applying based
>>> on state of PATCH 1/3 and 2/3.
>>
>> I assume you will take the patchset in your tree.
>>
>> I am back from vacations, give me a couple of days to review the
>> patchset before applying it please.
>>
>> Thanks
>>    -- Daniel
>>
>
> Hi, Daniel
>
> Do you have any comments on this patch series?
> Can we expect it in k3.14

I have applied the patch 1/3 and 2/3 in my tree but I was expecting the 
DT folks to give their acked-by for the patch 2/3.

It is a bit late for 3.14 but if the patch 3/3 is in Santosh's tree, the 
patch 2/3 gets its acked-by and you absolutely need the driver for this 
version, I may consider to send another PR to the upstream maintainers. 
That will be up to them to accept to pull it or not.

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
