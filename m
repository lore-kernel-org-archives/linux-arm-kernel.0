From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Jan 2017 22:16:40 +0800
Subject: [PATCH v6 02/14] irqchip: gic-v3-its: keep the head file include
 in alphabetic order
In-Reply-To: <ef759a3a-bbdb-2586-24a8-6ad650b07d41@suse.com>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-3-git-send-email-hanjun.guo@linaro.org>
 <ef759a3a-bbdb-2586-24a8-6ad650b07d41@suse.com>
Message-ID: <58763E48.9050006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 06:20 PM, Matthias Brugger wrote:
>
>
> On 02/01/17 14:31, Hanjun Guo wrote:
>> The head file is strictly in alphabetic order now, so let's
>> be the rule breaker. As acpi_iort.h includes acpi.h so remove
>> the duplidate acpi.h inclusion as well.
>>
>
> Sounds strange, maybe someting like:
> Rearrange header file includes to alphabetic order. As acpi_iort.h...

It's better, will update the patch.

Thanks
Hanjun
