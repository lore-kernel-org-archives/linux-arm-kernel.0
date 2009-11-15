From: kaloz@openwrt.org (Imre Kaloz)
Date: Sun, 15 Nov 2009 21:18:45 +0100
Subject: IXP4xx: unneeded #include platform-specific include files?
In-Reply-To: <19200.18453.644399.845601@pilspetsen.it.uu.se>
References: <m3fx8fso72.fsf@intrepid.localdomain>
	<19200.18453.644399.845601@pilspetsen.it.uu.se>
Message-ID: <op.u3gddjdi2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 15 Nov 2009 19:27:33 +0100, Mikael Pettersson <mikpe@it.uu.se> wrote:

> Krzysztof Halasa writes:
>  > I'm going to move them to the platform code, either incorporate them
>  > into platform .c files or #include "specific-platform.h" from there.
>  >
>  > Objections?
>
> None. Having worked on the Synology DS101 support for mach-ixp4xx
> I'm 99,99% certain that platform details can and should be private.
>

Or people can simply stop the #define brain damage and use the GPIO defines.

(hint: IRQ_IXP4XX_GPIO* for PCI stuff, and the gpio number in i2c_gpio_platform_data)


Imre
