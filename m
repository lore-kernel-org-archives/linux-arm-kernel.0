From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Jan 2017 07:21:20 -0800
Subject: [PATCH v3] ARM: OMAP1/2: clock: Remove unused mpurate cmdline
 option
In-Reply-To: <1485209043-26463-1-git-send-email-amurray@embedded-bits.co.uk>
References: <1485209043-26463-1-git-send-email-amurray@embedded-bits.co.uk>
Message-ID: <20170124152119.GE7403@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew Murray <amurray@embedded-bits.co.uk> [170123 14:05]:
> The 'mpurate' option, historically used for specifying an initial
> MPU rate at boot, no longer has any effect due to the supporting
> code being removed as it was 'wrong and dangerous' [1].
> 
> This patch removes the remaining dead code associated with the
> __setup macros to avoid confusion and reduce bloat.
> 
> [1] https://patchwork.kernel.org/patch/5954631/
> 
> Signed-off-by: Andrew Murray <amurray@embedded-bits.co.uk>
> ---
> Changes since v1:
> 
>  * Remove related omap2_clk_print_new_rates function which is also unused
>    (this was previously used to print clock rates after use of mpurate)
> 
> Changes since v2:
> 
>  * Add missing Signed-off-by

Applying into omap-for-v4.11/soc with Aaro's ack from the previsou
version.

Thanks,

Tony
