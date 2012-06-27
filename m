From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 27 Jun 2012 12:14:31 +0300
Subject: [PATCH v11 0/4] MTD: at91: Add PMECC support for at91 nand
 flash driver
In-Reply-To: <4FEAC6B2.6030104@atmel.com>
References: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
 <1340768981.2317.7.camel@koala> <4FEA87E5.9010604@atmel.com>
 <1340771320.2317.13.camel@koala> <4FEAC6B2.6030104@atmel.com>
Message-ID: <1340788471.29342.4.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-27 at 10:39 +0200, Nicolas Ferre wrote:
> AT91 is looked after carefully, yes it is.
> 
> The thing is that CAP9 SoC (the defconfig that you are using)
> has been obsoleted then removed for 3.4:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9918ceafd4a9e013572e03983f528017c29bb1cb

Ok, sorry for that phrase. I basically only need to do compile-testing.
And I only care about atmel_nand, so I take a defconfig, disable most of
the stuff, and use it for compilation. And when this minimal defconfig
stops working, I get upstet. If you have any suggestion what should I
base my configuration on, please, let me know.

Thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/bf5b8266/attachment.sig>
