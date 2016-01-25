From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Jan 2016 14:57:04 +0100
Subject: [PATCH] ARM64: tegra: Add chosen node for tegra132 norrin
In-Reply-To: <1450704171-8345-1-git-send-email-jonathanh@nvidia.com>
References: <1450704171-8345-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <20160125135704.GA7014@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 01:22:51PM +0000, Jon Hunter wrote:
> The NVIDIA bootloader, nvtboot, expects the "chosen" node to be present
> in the device-tree blob and it is not then it fails to boot the kernel.

"if it is not"

> Add the chosen node so we can boot the kernel on tegra132 norrin with

"Tegra132 Norrin"

> the nvtboot bootloader.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 2 ++
>  1 file changed, 2 insertions(+)

Otherwise looks good to me. Given that this is a fix for v4.5 material,
you might want to send it directly to arm at vger.kernel.org (and perhaps
mention that you'd like to have this applied to v4.5). With the above
two fixups:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/1a6529b0/attachment.sig>
