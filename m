From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Sep 2014 15:47:52 +0100
Subject: [PATCH 3/6] arm64: dts/Makefile: Add support for Spreadtrum's
 Shark64 SoC.
In-Reply-To: <1411992293-7729-4-git-send-email-zhang.lyra@gmail.com>
References: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
 <1411992293-7729-4-git-send-email-zhang.lyra@gmail.com>
Message-ID: <20140929144752.GP16977@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 08:04:50PM +0800, zhang.lyra at gmail.com wrote:

>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
> +dtb-$(CONFIG_ARCH_SHARK64) += sprd_shark64.dtb

It's better to keep lists in Makefiles and Kconfig sorted
alphanumerically, that way there's less chance of conflicts when
applying patches or merging different branches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/57e2fa07/attachment.sig>
