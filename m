From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 20 Jan 2017 16:50:17 +0000
Subject: [PATCH RESEND] arm: hisi: drop extern hip01_cpu_die
In-Reply-To: <1484719030-34755-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1484719030-34755-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <58823FC9.7050609@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

On 2017/1/18 5:57, Kefeng Wang wrote:
> Since the hip01 doesn't support cpu hotplug now, and doesn't implement
> the hip01_cpu_die function, drop the declaration.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Applied to the hisilicon soc tree.
Thanks!

Best Regards,
Wei

>  arch/arm/mach-hisi/core.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
> index e883583..c58b68a 100644
> --- a/arch/arm/mach-hisi/core.h
> +++ b/arch/arm/mach-hisi/core.h
> @@ -15,5 +15,4 @@
>  extern void hix5hd2_cpu_die(unsigned int cpu);
>  
>  extern void hip01_set_cpu(int cpu, bool enable);
> -extern void hip01_cpu_die(unsigned int cpu);
>  #endif
> 
