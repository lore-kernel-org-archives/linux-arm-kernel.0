From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 May 2014 00:33:53 +0900
Subject: [PATCH] ARM: EXYNOS: Use wfi macro in platform_do_lowpower
In-Reply-To: <CAM7CM0kG-fWcAo9rTwRj1iPD7EFSDVZWaPc93XmLVE=s_ePDpw@mail.gmail.com>
References: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org>
 <537E497B.9020404@linaro.org>
 <CAM7CM0kG-fWcAo9rTwRj1iPD7EFSDVZWaPc93XmLVE=s_ePDpw@mail.gmail.com>
Message-ID: <5384B061.7070507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/14 15:13, Leela Krishna Amudala wrote:
> Hi Kgene,
>
Hi,

>
> On Fri, May 23, 2014 at 12:31 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org>  wrote:
>> On 05/22/2014 09:57 AM, Leela Krishna Amudala wrote:
>>>
>>> This patch is originally based on commit b3377d186572 ("ARM: 7064/1:
>>> vexpress: Use wfi macro in platform_do_lowpower.")
>>>
>>> Current Exynos CPU hotplug code includes a hardcoded WFI
>>> instruction, in ARM encoding.  When the kernel is compiled in Thumb-2
>>> mode, this is invalid and causes the machine to hang hard when a CPU
>>> is offlined.
>>>
>>> Use wfi macro instead of the hardcoded WFI instruction.
>>>
>>> Signed-off-by: Leela Krishna Amudala<leela.krishna@linaro.org>
>>
>>
>> Acked-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>>
>
> Can you please take action on this patch.
>
Applied, thanks.

- Kukjin
