From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 24 Jan 2017 18:49:12 +0800
Subject: [PATCH 0/2] arch_timer: acpi: Add workaround for
 hisilicon-161010101 erratum
In-Reply-To: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
Message-ID: <41bee749-ff22-1ffc-e428-c4af85229bb0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/1/24 18:39, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> Introduce a general quirk framework for arch timer erratum in ACPI,
> which use the oem information in GTDT table for platform specific
> erratums, then add specific handler and data for hisilicon-161010101
> erratum.

Sorry, forgot to mention that this patch set is based on Mark's git
tree [1] and plus remaining patches for GTDT patch set.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git 
arch-timer/updates

Thanks
Hanjun
