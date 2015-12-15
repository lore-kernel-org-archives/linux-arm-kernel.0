From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 16 Dec 2015 08:32:02 +0900
Subject: [PATCH 12/19] ARM: dts: exynos: replace legacy *, wakeup property
 with wakeup-source
In-Reply-To: <56704141.8070308@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-13-git-send-email-sudeep.holla@arm.com>
 <56704141.8070308@arm.com>
Message-ID: <5670A2F2.5060009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.12.2015 01:35, Sudeep Holla wrote:
> 
> 
> On 21/10/15 11:10, Sudeep Holla wrote:
>> Though the keyboard and other driver will continue to support the legacy
>> "gpio-key,wakeup", "linux-keypad,wakeup" boolean property to enable the
>> wakeup source, "wakeup-source" is the new standard binding.
>>
>> This patch replaces all the legacy wakeup properties with the unified
>> "wakeup-source" property in order to avoid any futher copy-paste
>> duplication.
>>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Ping, do you prefer taking via your tree or should I send to armsoc
> directly ?

Usually it depends on the dependencies... but:
1. I just received this patch - 12/19.
2. No cover letter, no other patches, no explanation about any
dependencies or other related changes. Nothing. Just one patch.
3. The patch mentions new standard binding. Was the new binding already
merged? Or is it part of these series? What about backward compatibility?

BR,
Krzysztof
