From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 3 Aug 2012 15:23:49 -0300
Subject: [PATCH] MXS: Fix mxs_defconfig MMAP_MIN_ADDR
In-Reply-To: <20120803174016.GE10335@n2100.arm.linux.org.uk>
References: <1344009354-13249-1-git-send-email-marex@denx.de>
 <CAOMZO5DZui3x554WcHsseSfXDgYeaq1va-QzVy1CQajE3M3=kQ@mail.gmail.com>
 <CAOMZO5AzaDcxJJV+Z-bHH58=xRq5RY6BanEjMd4uUhN+K9ZNZQ@mail.gmail.com>
 <20120803174016.GE10335@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5D=L=H6bnsoFcvedzdrdTGUFL2Ztyr4tLy9wbxpZ7a9ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 3, 2012 at 2:40 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> 4096 is also fine for ARM too.  There's not much point in having
> defconfigs change it - that would just be pure noise in the config
> files.

Thanks for the clarification, Russell.

Marek, so maybe you can send a v2 of this patch with my previous
suggestion (and also mentioning the offending commit).

I have also removed CONFIG_DEFAULT_MMAP_MIN_ADDR from imx_v6_v7_defconfig.

Regards,

Fabio Estevam
