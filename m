From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Jun 2015 12:49:20 +0200
Subject: [RFC] arm: Add for atomic half word exchange
In-Reply-To: <146879519.394951433226103227.JavaMail.weblogic@epmlwas06d>
References: <146879519.394951433226103227.JavaMail.weblogic@epmlwas06d>
Message-ID: <3482663.LChMlKYgkA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 June 2015 06:21:43 Sarbojit Ganguly wrote:
> Hello Raghavendra,
> 
> That is exactly I had done albeit from menuconfig. Basically the whole point was to make sure my patch compiles against ARM11 architectures as well. Hence I ensured the .config contains the relevant flags on. 
> 
> 

Most ARM11 implementations are ARMv6k, which has support for the instruction,
but the older ARMv6 (without k) does not. From your description, I assume
you only tested with ARMv6k, not ARMv6. Please enable the OMAP2 and IMX31
platforms to test ARMv6.

	Arnd
