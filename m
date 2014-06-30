From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Mon, 30 Jun 2014 18:21:04 +0100
Subject: [PATCH v4 05/13] ARM64 / ACPI: Introduce arm-core.c and its
 related head file
In-Reply-To: <20140630162406.GR28951@arm.com>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
 <1403840976-7456-6-git-send-email-hanjun.guo@linaro.org>
 <20140630162406.GR28951@arm.com>
Message-ID: <53B19C80.8060306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 30/06/2014 17:24, Catalin Marinas wrote:
> On Fri, Jun 27, 2014 at 04:49:28AM +0100, Hanjun Guo wrote:
>>   drivers/acpi/Makefile          |    2 +
>>   drivers/acpi/plat/Makefile     |    1 +
>>   drivers/acpi/plat/arm-core.c   |  110 ++++++++++++++++++++++++++++++++++++++++
> Do you ever plan to add ACPI support for 32-bit ARM? If not, this part
> could be placed under arch/arm64 (similar to x86).
>
Originally the plan was to support both platforms, but it seems people 
have stopped talking to Linaro about 32bit support now so unless anyone 
else has some actual info I guess it would be safe to move it into arm64.

Graeme
