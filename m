From: b-cousson@ti.com (Cousson, Benoit)
Date: Sat, 06 Nov 2010 14:21:39 -0400
Subject: [PATCH v2 7/7] omap: mailbox: remove unreachable return
In-Reply-To: <1289006244-27147-8-git-send-email-omar.ramirez@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
	<1289006244-27147-8-git-send-email-omar.ramirez@ti.com>
Message-ID: <4CD59CB3.2060306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/5/2010 9:17 PM, Ramirez Luna, Omar wrote:
> Remove unreachable return statement.
>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   arch/arm/mach-omap2/mailbox.c |    2 --
>   1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 5e9ea0f..335eb2b 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -434,8 +434,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>   		return ret;
>   	}

Please add a blank line here.

Otherwise you can add: Acked-by: Benoit Cousson <b-cousson@ti.com>

Thanks,
Benoit

>   	return 0;
> -
> -	return ret;
>   }
>
>   static int __devexit omap2_mbox_remove(struct platform_device *pdev)
