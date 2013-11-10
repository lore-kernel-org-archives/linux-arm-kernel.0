From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 11 Nov 2013 08:14:51 +0900
Subject: [PATCH] MAINTAINERS: Add entry for Samsung SoC clock drivers
In-Reply-To: <1383963454-2749-1-git-send-email-tomasz.figa@gmail.com>
References: <1383963454-2749-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <002201cede6a$a8a183a0$f9e48ae0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, November 09, 2013 11:18 AM, Tomasz Figa wrote:
> 
> From: Tomasz Figa <t.figa@samsung.com>
> 
> This patch adds an entry for Samsung SoC clock drivers located under
> drivers/clk/samsung/ directory, with me taking the maintainer role.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Mike Turquette <mturquette@linaro.org>
> Acked-by: Sachin Kamat <sachin.kamat@linaro.org>
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

It looks good.

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61b8757..df7e1bf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7319,6 +7319,12 @@ L:	linux-media at vger.kernel.org
>  S:	Supported
>  F:	drivers/media/i2c/s5c73m3/*
> 
> +SAMSUNG SOC CLOCK DRIVERS
> +M:	Tomasz Figa <t.figa@samsung.com>
> +S:	Supported
> +L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
> +F:	drivers/clk/samsung/
> +
>  SERIAL DRIVERS
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  L:	linux-serial at vger.kernel.org
> --
> 1.8.4.2
