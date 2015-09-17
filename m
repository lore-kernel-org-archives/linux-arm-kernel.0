From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Thu, 17 Sep 2015 09:32:34 +0800
Subject: [PATCH v2 00/22] KVM: ARM64: Add guest PMU support
In-Reply-To: <55F9D9FC.6010905@redhat.com>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
 <55F9D9FC.6010905@redhat.com>
Message-ID: <55FA1832.3040008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On 2015/9/17 5:07, Wei Huang wrote:
> I am testing this series. 
Thanks for your time and help.

> The first question is: do you plan to add ACPI
> support in QEMU?
To the completeness, this should be added. Maybe this could be added at
v3. But I have a look at the kernel PMU driver, it doesn't support
probing through ACPI, although there are some patches[1] out-of-tree.

> My in-house kernel uses ACPI for device probing. I had
> to force "acpi=off" when I test this patch series.
Guest kernel only boots with ACPI when you add "acpi=force". No need to
add "acpi=off".

Thanks,

[1] http://marc.info/?l=linaro-acpi&m=137949337925645&w=2
-- 
Shannon
