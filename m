From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Sep 2012 08:38:38 +0900
Subject: [PATCH v3] ARM: S3C24XX: Add WIZnet W5300E01-ARM board support
In-Reply-To: <1346905640.2573.14.camel@taehun-desktop>
References: <1346653236-19728-1-git-send-email-kth3321@gmail.com>
 <1346905640.2573.14.camel@taehun-desktop>
Message-ID: <09a301cd96bf$e48b5970$ada20c50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Taehun Kim wrote:
> 
> - The gpio routines are changed to use the gpio_request() functions from
>   comments of Vasily and Sylwester.
> - The mistake of adding a character by my email client automatically is
> fixed.
> 
> Please review this patch and apply it if do not have any problems.
> 

Taehun,

Above area is for adding comments like 'This patch adds WIZnet W5300E01 board' because it will be remained in its git log and nobody want to see your old request in there. If any comments which are not related to changes just put it after '---' around your sign. It doesn't hurt your patch.

And you need to update this against on for-next of my tree because some S3C2410 gpio APIs have been gone.(See the Sylwester's comments) Please re-send this.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> Signed-off-by: Taehun Kim <kth3321@gmail.com>
> ---
>  arch/arm/mach-s3c24xx/Kconfig         |    5 +
>  arch/arm/mach-s3c24xx/Makefile        |    1 +
>  arch/arm/mach-s3c24xx/mach-w5300e01.c |  193
> +++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 arch/arm/mach-s3c24xx/mach-w5300e01.c
>  
[snip]
