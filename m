From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 16 Jan 2015 16:37:10 +0800
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <54B819E0.1050508@redhat.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <54B819E0.1050508@redhat.com>
Message-ID: <54B8CDB6.60100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?01?16? 03:49, Mark Langsdorf wrote:
> On 01/14/2015 09:04 AM, Hanjun Guo wrote:
>> Hi,
>>
>> This is the v7 of ACPI core patches for ARM64 based on ACPI 5.1
>
>> 1. Why we need ACPI on ARM64?
>>
>>    - Grant already posted a blog about this, and stated clearly
>>      why we need ACPI on ARM64:
>>
>>      http://www.secretlab.ca/archives/151
>>
>>
>> 2. What we need to do before the arm64 ACPI core patches
>>     could be merged into the kernel?
>>
>>    - Al Stone posted a TODO list and updates v2 for the
>>      progress we made:
>>      http://www.spinics.net/lists/arm-kernel/msg390069.html
>>
>>    - so from the progress we can see that we already finished
>>      most of the items, and _OSI we got a plan to fix it, RFC
>>      patch is on the way.
>>
>>
>> This patch set was tested on FVP by Fuwei, and booted ok as expected.
>> (No functional change since last version)
>
> For what it's worth, I applied these to the latest 3.19-rc4 kernel
> and booted that on an APM X-Gene and on pre-release AMD hardware.
> I then ran a couple of stress tests such as kernel compiles and
> filesystem stressers on the systems.

Thanks a lot!

Hanjun
