From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 28 Oct 2011 09:11:29 +0200
Subject: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
In-Reply-To: <1319772453-1275-1-git-send-email-Barry.Song@csr.com>
References: <1319772453-1275-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20111028071129.GA2362@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

On Thu, Oct 27, 2011 at 08:27:33PM -0700, Barry Song wrote:
> From: Rong Wang <Rong.Wang@csr.com>
> 
> SiRFprimaII is the latest generation application processor from CSR?s
> multi-function SoC product family.
> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> 3.0.
> 
> There are three dedicated UARTs in system. This patch adds basic driver
> support for them.
> 
> It has used the newest pinmux subsystem from Linus Walleij.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rong Wang <Rong.Wang@csr.com>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Acked-by: Alan Cox <alan@linux.intel.com>
> ---

[snip]

> +config SERIAL_SIRFSOC
> +        tristate "SiRF SoC Platform Serial port support"
> +        depends on ARM && ARCH_PRIMA2
> +        select SERIAL_CORE
> +        help
> +          Support for the on-chip UART on the CSR SiRFprimaII series,
> +          providing /dev/ttyS0, 1 and 2 (note, some machines may not
> +          provide all of these ports, depending on how the serial port
> +          pins are configured.

Unbalanced parentheses.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
