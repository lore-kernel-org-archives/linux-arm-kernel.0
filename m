From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Feb 2016 12:20:23 -0800
Subject: [RESEND PATCH V2] ARM64: tegra: Add chosen node for tegra132
 norrin
In-Reply-To: <1453753555-14634-1-git-send-email-jonathanh@nvidia.com>
References: <1453753555-14634-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <20160201202023.GF13508@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 08:25:55PM +0000, Jon Hunter wrote:
> The NVIDIA bootloader, nvtboot, expects the "chosen" node to be present
> in the device-tree blob and if it is not then it fails to boot the kernel.
> Add the chosen node so we can boot the kernel on Tegra132 Norrin with the
> nvtboot bootloader.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> v1 -> v2 changes:
> - minor fixes to commit message
> 
> Ideally, we would like to get this into v4.5 as a fix for Tegra132 Norrin
> so that we can enable booting this board as part of our automated testing
> setup for Tegra [0][1]. Thierry suggested I send this directly as a fix
> to ARM-SOC. Let me know if this is ok. I have not included a "fixes" as it
> may not be needed for all bootloaders, but if you need this we could put:
> 
> Fixes: 0f279eb arm64: tegra: Add NVIDIA Tegra132 Norrin support
> 
> [0] http://nvtb.github.io/linux/
> [1] http://nvtb.github.io/linux-next/

Applied to fixes. Thanks.


-Olof
