From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 16:48:30 -0800
Subject: [GIT PULL 3/5] omap device tree changes for v4.10
In-Reply-To: <582b7c9b.0111620a.395b.cabdSMTPIN_ADDED_BROKEN@mx.google.com>
References: <pull-1479236877-351747>
 <582b7c9b.0111620a.395b.cabdSMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20161119004830.GF15902@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 15, 2016 at 01:22:21PM -0800, Tony Lindgren wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/dt-signed
> 
> for you to fetch changes up to 7e2f8c0ae670327cbe0348ad2f3df7d9a55a8e5d:
> 
>   ARM: dts: Add minimal support for motorola droid 4 xt894 (2016-11-15 10:28:49 -0800)
> 
> ----------------------------------------------------------------
> Device tree changes for omaps for v4.10 merge window:
> 
> - A series of patches to configure tps65217 PMIC interrupts for
>   power button, charger and usb and use them on am335x
> 
> - Configure EEPROM, LEDs and USR1 button for omap5 boards
> 
> - Add tscadc DMA properites for am33xx and am4372
> 
> - Configure baltos-ir5221 both musb channels to host mode
> 
> - Configure internal and external RTC clocks for am335x boards
> 
> - Don't reset gpio3 block on baltos
> 
> - Remove pinmux for dra72-evm for erratum i869, fix the regulators
>   and seprate out tps65917 support
> 
> - Add dra718-evm support
> 
> - Add minimal droid 4 xt894 support

Another phone, cool to see even though it's no longer being sold.

Merged, thanks.


-Olof
