From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 19 Aug 2012 22:21:19 +0300
Subject: [PATCH 1/8] arm: sam9_l9260_defconfig: adjust UBI bad
 eraseblocks limit
In-Reply-To: <1345214124-5478-2-git-send-email-richard.genoud@gmail.com>
References: <1345214124-5478-1-git-send-email-richard.genoud@gmail.com>
 <1345214124-5478-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <1345404079.1930.7.camel@kyv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-17 at 16:35 +0200, Richard Genoud wrote:
> diff --git a/arch/arm/configs/sam9_l9260_defconfig b/arch/arm/configs/sam9_l9260_defconfig
> index da276f9..d11fea5 100644
> --- a/arch/arm/configs/sam9_l9260_defconfig
> +++ b/arch/arm/configs/sam9_l9260_defconfig
> @@ -39,7 +39,7 @@ CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_ATMEL=y
>  CONFIG_MTD_NAND_PLATFORM=y
>  CONFIG_MTD_UBI=y
> -CONFIG_MTD_UBI_BEB_LIMIT=3
> +CONFIG_MTD_UBI_BEB_LIMIT=30

I'll just remove this from from the defconfig and make it use the
default, which is more sensible for this device, as your research
showed.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120819/65142d0c/attachment-0001.sig>
