From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 24 Jan 2017 21:14:19 +0800
Subject: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
 deferred probing or error
In-Reply-To: <20170124123711.GA11996@red-moon>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-9-git-send-email-sricharan@codeaurora.org>
 <20170124123711.GA11996@red-moon>
Message-ID: <5887532B.3070506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo, Sricharan,

On 01/24/2017 08:37 PM, Lorenzo Pieralisi wrote:
> [+hanjun, tomasz, sinan]
>
> It is quite a key patchset, I would be glad if they can test on their
> respective platforms with IORT.

ACPI patches are conflict with my acpi platform msi patches (I need
them to enable devices on my ARM64 platform then test this patch set),
I will fix the conflict and test it tomorrow (out of office now and
can't reach the test machines) :)

Thanks
Hanjun
