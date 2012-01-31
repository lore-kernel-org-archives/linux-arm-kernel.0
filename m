From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jan 2012 11:20:24 +0800
Subject: [PATCH] ARM: devicetree: Add .dtb files to
 arch/arm/boot/.gitignore
In-Reply-To: <1327945574-7977-1-git-send-email-dave.martin@linaro.org>
References: <1327945574-7977-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20120131032022.GC24681@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 05:46:14PM +0000, Dave Martin wrote:
> Compiled device tree blobs shouldn't be committed in the kernel
> tree, so ideally git should ignore them.
> 
> This patch will enable ignoring of any .dtb files which appear in
> arch/arm/boot/
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

I added my ack tag on the same patch below, but it died in the end?

http://comments.gmane.org/gmane.linux.ports.arm.kernel/144097

Regards,
Shawn

> ---
>  arch/arm/boot/.gitignore |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
> index ce1c5ff..3c79f85 100644
> --- a/arch/arm/boot/.gitignore
> +++ b/arch/arm/boot/.gitignore
> @@ -3,3 +3,4 @@ zImage
>  xipImage
>  bootpImage
>  uImage
> +*.dtb
> -- 
> 1.7.4.1
