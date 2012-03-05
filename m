From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 05 Mar 2012 15:31:13 +0530
Subject: [PATCHv4 0/6] ARM: OMAP3+: IO daisychain support fixes
In-Reply-To: <1330701475-22576-1-git-send-email-t-kristo@ti.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com>
Message-ID: <4F548EE9.6050805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012 08:47 PM, Tero Kristo wrote:
> Hi,
>
> Changes compared to previous version:
>
> - patch2:
>   * changed timeout value to 100us (from 1000)
>   * added poll for the IO status == 0 at the end of trigger sequence
> - patch4:
>   * omap3: global wakeup done in PRM init instead of OMAP3 PM init
>   * omap4: moved global wakeup enable from trigger func to PRM init
>
> Tested on omap3beagle / omap4blaze, suspend / resume works with io chain.

for the full series,
Reviewed-by: Rajendra Nayak <rnayak@ti.com>

>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
