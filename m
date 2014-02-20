From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Feb 2014 00:23:16 -0800
Subject: [GIT PULL 00/21] Renesas ARM based SoC Board Updates for v3.15
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <20140220082316.GE19089@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 03:17:08PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> please consider these Renesas ARM based SoC board updates for v3.15.
> 
> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.15
> 
> for you to fetch changes up to 235cda29e4d5047622ff9b82b1f0b4cb6cf95f6c:
> 
>   ARM: shmobile: Remove Lager USBHS UDC ifdefs (2014-02-04 14:28:33 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based SoC Board Updates for v3.15
> 
> * r8a7791 (R-Car M2) based Koelsch board
>   - Fix error return code check from clk_get()
>   - Add SATA0 support
>   - Conditionally select MICREL_PHY for Multiplatform
> 
> * r8a7790 (R-Car H2) based Lager board
>   - Add USBHS support
>   - Fix error return code check from clk_get()
>   - Add SATA support
>   - Make spi_flash_data const
>   - Add VIN1 SoC camera support
>   - Conditionally select CONFIG_MICREL_PHY
> 
> * r8a7778 (R-Car M1) based Bock-W board
>   - Add USB Func DMAEngine support
>   - Use HPBIF DMAEngine for sound
>   - Use SSI DMAEngine for sound
> 
> * emev2 (Emma Mobile EV2) based kzm9d board
>   - Use common clock framework
> 
> * r8a773a0 (SH-Mobile AG5) based kzm9g board
>   - Add zboot support
> 
> * Many boards
>   - Conditionally select SMSC_PHY

Simon,

I've pulled this into next/boards (as renesas/boards), but I'd like to get an
understanding of how much more legacy board code you expect to add. I'd like to
see it slow down to nearly nothing as things move over to device tree, and I'm
a little confused that we've still got this much coming in.


Thanks!

-Olof
