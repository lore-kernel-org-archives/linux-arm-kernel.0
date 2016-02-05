From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 5 Feb 2016 09:56:39 -0800
Subject: [PATCH] ARM: keystone: remove redundant depends on
 ARM_PATCH_PHYS_VIRT
In-Reply-To: <1454694041-14990-1-git-send-email-yamada.masahiro@socionext.com>
References: <1454694041-14990-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <56B4E257.5050308@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/5/2016 9:40 AM, Masahiro Yamada wrote:
> KeyStone is Multi-platform.  ARM_PATCH_PHYS_VIRT is already select'ed
> by ARCH_MULTIPLATFORM.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
There is also Keystone config so its nit redundant as you think.

P.S: arch/arm/configs/keystone_defconfig

Regards,
Santosh
