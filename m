From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 13 Jul 2012 09:25:55 +0530
Subject: [PATCH v5 6/6] spi: s3c64xx: add device tree support
In-Reply-To: <4FFF51EE.4080609@samsung.com>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
 <1342021265-11212-7-git-send-email-thomas.abraham@linaro.org>
 <4FFF51EE.4080609@samsung.com>
Message-ID: <CAJuYYwQBL6OGJM41e9kD2ATUj3g9NTs-OC+G_gMKMScn3ms=hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 July 2012 04:08, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas, the DMACH_DT_PROP is available only on pl330 now. So seems occur
> following build error with s3c6400_defconfig.
>
> drivers/spi/spi-s3c64xx.c: In function 's3c64xx_spi_get_dmares':
> drivers/spi/spi-s3c64xx.c:1098: error: 'DMACH_DT_PROP' undeclared (first use
> in this function)
> drivers/spi/spi-s3c64xx.c:1098: error: (Each undeclared identifier is
> reported only once
> drivers/spi/spi-s3c64xx.c:1098: error: for each function it appears in.)
> make[3]: *** [drivers/spi/spi-s3c64xx.o] Error 1
> make[2]: *** [drivers/spi] Error 2
>

Dear Mr. Kim,

Thanks for considering these patches to be merged via your tree. For
the build break you mentioned above, there was a patch submitted some
time back to handle this. The link to that patch is:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/102627.html.
Could you please apply this patch also to your tree.

Thanks,
Thomas.
