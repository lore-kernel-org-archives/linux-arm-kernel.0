From: gnurou@gmail.com (Alexandre Courbot)
Date: Thu, 11 Feb 2016 17:32:13 +0900
Subject: [PATCH V3] ARM64: tegra: Add support for Google Pixel C
In-Reply-To: <1455020809-17531-1-git-send-email-jonathanh@nvidia.com>
References: <1454949199-27050-1-git-send-email-jonathanh@nvidia.com>
 <1455020809-17531-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <CAAVeFuJt+VdJb4S3PC-RXVFYhLnq7yF+dV_w5or=0ebG+LnnGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 9, 2016 at 9:26 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
> Add initial device-tree support for Google Pixel C (a.k.a. Smaug) based
> upon Tegra210 SoC with 3 GiB of LPDDR4 RAM.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

I need to add "clk_ignore_unused=1" to the bootargs in order to avoid
a hang during boot, but otherwise can reach a serial console.

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
