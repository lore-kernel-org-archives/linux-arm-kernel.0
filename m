From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 28 Jun 2016 18:36:34 +0100
Subject: [PATCH v11 0/3] ARM: hisi: Add initial support for Hi3519 SOC
In-Reply-To: <1465957147-32314-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1465957147-32314-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <5772B5A2.7030404@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiancheng,

On 15/06/2016 03:19, Jiancheng Xue wrote:
> These three patches are abstracted from the patchset titled
> "[RESEND PATCH v10 0/6] ARM: hisi: Add initial support including
> clock driver for Hi3519 soc."(https://lkml.org/lkml/2016/3/31/175).
> The clock driver part was merged in v4.7-rc1. This patch set
> is mainly used to enable Hi3519 basic soc and add dts files.
> 
> Jiancheng Xue (3):
>   ARM: hisi: add compatible string for Hi3519 soc
>   ARM: dt-bindings: add device tree bindings for Hi3519 sysctrl
>   ARM: dts: add dts files for Hi3519
> 

Thanks!
Applied all the 3 patches to the hisilicon soc tree.

I have modified the dts Makefile in the patch 3 and shuffled
the ARCH_HIGHBANK, ARCH_HISI and ARCH_HIX5HD2 around to
keep the list sorted.

Best Regards,
Wei
