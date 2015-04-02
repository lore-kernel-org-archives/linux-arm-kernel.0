From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 02 Apr 2015 16:47:21 +0900
Subject: [PATCH] KVM: arm64: add gic-400 compatible
In-Reply-To: <20140908222144.4967.80301.stgit@joelaarch64.amd.com>
References: <20140908222144.4967.80301.stgit@joelaarch64.amd.com>
Message-ID: <551CF409.1090707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.
This patch was acked but has never been merged?

-Takahiro AKASHI

On 09/09/2014 07:21 AM, Joel Schopp wrote:
> Add a one liner to identify the gic-400.  It's gicv2 with optional MSI extensions.
>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Joel Schopp <joel.schopp@amd.com>
> ---
>   virt/kvm/arm/vgic.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 73eba79..e81444e 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1550,6 +1550,7 @@ static struct notifier_block vgic_cpu_nb = {
>
>   static const struct of_device_id vgic_ids[] = {
>   	{ .compatible = "arm,cortex-a15-gic", .data = vgic_v2_probe, },
> +	{ .compatible = "arm,gic-400", .data = vgic_v2_probe, },
>   	{ .compatible = "arm,gic-v3", .data = vgic_v3_probe, },
>   	{},
>   };
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
