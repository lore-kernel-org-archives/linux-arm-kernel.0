From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sat, 28 Apr 2012 15:00:59 +0300
Subject: [PATCH v2 0/3] add gpmi-nand dt support for mx6q and mx28
In-Reply-To: <1335323184-11233-1-git-send-email-b32955@freescale.com>
References: <1335323184-11233-1-git-send-email-b32955@freescale.com>
Message-ID: <1335614459.1937.13.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-04-25 at 11:06 +0800, Huang Shijie wrote:
> The mx6q-arm2 and imx28evk have already support the device tree now.
> So i decide to add the gpmi-nand dt support to them.
> 
> The mx23 does not support the device tree now. I will add the gpmi dt support
> when it is ready.

I cannot apply these patches to l2-mtd.git:

Applying: ARM: mx28: add gpmi-nand dt support
error: arch/arm/boot/dts/imx28-evk.dts: does not exist in index
error: arch/arm/boot/dts/imx28.dtsi: does not exist in index

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120428/6f581371/attachment-0001.sig>
