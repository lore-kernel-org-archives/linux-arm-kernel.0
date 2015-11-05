From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Nov 2015 10:26:55 +0100
Subject: [PATCH 18/19] ARM: dts: ste: replace legacy *,wakeup property
 with wakeup-source
In-Reply-To: <562F7219.9010705@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-19-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYNFa-R8-u8JXijsCDyY+RHo4ANp+Voz3PEn6b9hcCrzQ@mail.gmail.com>
 <562F7219.9010705@arm.com>
Message-ID: <CACRpkdZYbZzWbZNCk7ZnNap=n59weCPA=m1jTJNPvXwR_NPsCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 1:46 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 27/10/15 12:34, Linus Walleij wrote:
>> On Wed, Oct 21, 2015 at 12:10 PM, Sudeep Holla <sudeep.holla@arm.com>
>> wrote:
>>
>>> Though the keyboard and other driver will continue to support the legacy
>>> "gpio-key,wakeup", "linux,wakeup" boolean property to enable the wakeup
>>> source, "wakeup-source" is the new standard binding.
>>>
>>> This patch replaces all the legacy wakeup properties with the unified
>>> "wakeup-source" property in order to avoid any futher copy-paste
>>> duplication.
>>>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Are you sending this to ARM SoC or do I need to handle the
>> patch?
>>
>
> Many platform maintainers preferred to pick up via their tree, so if you
> want to pick up with other STE patches, I am fine as there's no
> dependency on the driver changes.

Patch applied to my ux500-devicetree branch, sorry for the delay.

Yours,
Linus Walleij
