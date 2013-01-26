From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 26 Jan 2013 13:06:21 +0800
Subject: [PATCH RESEND] ARM: dts: max77686: Add DTS file for max77686 PMIC
In-Reply-To: <1359053177-17725-1-git-send-email-tobetter@gmail.com>
References: <1359053177-17725-1-git-send-email-tobetter@gmail.com>
Message-ID: <20130126050618.GD10580@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 03:46:08AM +0900, Dongjin Kim wrote:

> ---
>  arch/arm/boot/dts/max77686.dtsi |  156 +++++++++++++++++++++++++++++++++++++++

Why is this in arch/arm?  This isn't an ARM-specific chip.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130126/f1db9d87/attachment-0001.sig>
