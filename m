From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 11 Feb 2016 08:55:45 +0000
Subject: [PATCH V3] ARM64: tegra: Add support for Google Pixel C
In-Reply-To: <CAAVeFuJt+VdJb4S3PC-RXVFYhLnq7yF+dV_w5or=0ebG+LnnGw@mail.gmail.com>
References: <1454949199-27050-1-git-send-email-jonathanh@nvidia.com>
 <1455020809-17531-1-git-send-email-jonathanh@nvidia.com>
 <CAAVeFuJt+VdJb4S3PC-RXVFYhLnq7yF+dV_w5or=0ebG+LnnGw@mail.gmail.com>
Message-ID: <56BC4C91.6070409@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/02/16 08:32, Alexandre Courbot wrote:
> On Tue, Feb 9, 2016 at 9:26 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Add initial device-tree support for Google Pixel C (a.k.a. Smaug) based
>> upon Tegra210 SoC with 3 GiB of LPDDR4 RAM.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> I need to add "clk_ignore_unused=1" to the bootargs in order to avoid
> a hang during boot, but otherwise can reach a serial console.

Were you testing on -next? If so, you should not need that. Otherwise,
please make sure you have this patch [0]. Thierry has included this in a
clock fixes series that should turn up in main soon.

> Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks
Jon

[0] https://lkml.org/lkml/2015/12/18/390
