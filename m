From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 19 Jan 2017 11:57:04 +0800
Subject: [PATCH v13 0/7] Enable PMUs in ACPI systems
In-Reply-To: <1484686210-7211-1-git-send-email-jeremy.linton@arm.com>
References: <1484686210-7211-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1b75c424-dfe3-6382-a38a-d784ab495b43@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/1/18 4:50, Jeremy Linton wrote:
> This patch expands and reworks the patches published by Mark Salter
> in order to clean up a few of the previous review comments, as well as
> add support for newer CPUs and big/little configurations.
>
> v13:
> - Correct int/bool conversion bug in pmu_acpi_init()

I tested this patch set on Hisilicon D03 and using "perf list"
then I can get hardware event which it's not available before
adding this patch set, and "perf stat -e <event>" works fine
with available perf event.

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
