From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 08 Nov 2012 15:14:07 +0000
Subject: [GIT PULL] vexpress: fixes for v3.8
In-Reply-To: <201211081405.23202.arnd@arndb.de>
References: <1350580125.4984.23.camel@hornet>
 <201211081405.23202.arnd@arndb.de>
Message-ID: <1352387647.20549.10.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-11-08 at 14:05 +0000, Arnd Bergmann wrote:
> diff --git a/arch/arm/include/debug/vexpress.S b/arch/arm/include/debug/vexpress.S
> index 0c6abbf..dc8e882 100644
> --- a/arch/arm/include/debug/vexpress.S
> +++ b/arch/arm/include/debug/vexpress.S
> @@ -21,6 +21,7 @@
>  #if defined(CONFIG_DEBUG_VEXPRESS_UART0_DETECT)
>  
>  		.macro	addruart,rp,rv,tmp
> +		.arch   armv7-a

Yes, will you apply it on your side (or fold it into the existing
change) or do you want me to post a patch (or to update the
vexpress-fixes branch?)

Thanks for spotting this!

Pawe?
