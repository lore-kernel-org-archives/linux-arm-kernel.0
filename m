From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 21:04:29 +0900
Subject: [PATCH 9/9] ARM: remove mach .handle_irq for VIC users
In-Reply-To: <1353466713-18967-10-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
 <1353466713-18967-10-git-send-email-robherring2@gmail.com>
Message-ID: <0e6b01cdc7e0$5c2eb8e0$148c2aa0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring wrote:
> 
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that the VIC initialization sets up the handle_arch_irq pointer, we
> can remove it for all machines and make it static.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Hubert Feurstein <hubert.feurstein@contec.at>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> ---

[...]

>  arch/arm/mach-s3c64xx/mach-anw6410.c   |    1 -
>  arch/arm/mach-s3c64xx/mach-crag6410.c  |    1 -
>  arch/arm/mach-s3c64xx/mach-hmt.c       |    1 -
>  arch/arm/mach-s3c64xx/mach-mini6410.c  |    1 -
>  arch/arm/mach-s3c64xx/mach-ncp.c       |    1 -
>  arch/arm/mach-s3c64xx/mach-real6410.c  |    1 -
>  arch/arm/mach-s3c64xx/mach-smartq5.c   |    1 -
>  arch/arm/mach-s3c64xx/mach-smartq7.c   |    1 -
>  arch/arm/mach-s3c64xx/mach-smdk6400.c  |    1 -
>  arch/arm/mach-s3c64xx/mach-smdk6410.c  |    1 -
>  arch/arm/mach-s5p64x0/mach-smdk6440.c  |    1 -
>  arch/arm/mach-s5p64x0/mach-smdk6450.c  |    1 -
>  arch/arm/mach-s5pc100/mach-smdkc100.c  |    1 -
>  arch/arm/mach-s5pv210/mach-aquila.c    |    1 -
>  arch/arm/mach-s5pv210/mach-goni.c      |    1 -
>  arch/arm/mach-s5pv210/mach-smdkc110.c  |    1 -
>  arch/arm/mach-s5pv210/mach-smdkv210.c  |    1 -
>  arch/arm/mach-s5pv210/mach-torbreck.c  |    1 -

For above s3c64xx, s5p64x0, s5pc100 and s5pv210,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
