From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Oct 2018 16:07:04 +0200
Subject: [GIT PULL] SoCFPGA DTS updates for v4.20, part 3, take 2
In-Reply-To: <20181010151002.10645-1-dinguyen@kernel.org>
References: <20181010151002.10645-1-dinguyen@kernel.org>
Message-ID: <CAK8P3a3vrTR1oDuvh-oEiOTUQJM+nvy1HxenTGN3PXg0+eszvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/18, Dinh Nguyen <dinguyen@kernel.org> wrote:
> Hi Arnd, Kevin, and Olof:
>
> Please pull in these additional patches for v4.20.
>
> Thanks,
> Dinh
>
> The following changes since commit
> 20373e0cb8f7d540ae082a8026f5ae7c27cc6cb3:
>
>   ARM: dts: socfpga: add timer resets for SoCFPGA platform (2018-09-17
> 10:11:28 -0500)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
> tags/socfpga_updates_for_v4.20_part3
>
> for you to fetch changes up to 2a44d6511a0104e9ff628e73cf4381e5664a8219:
>
>   ARM: dts: socfgpa: remove ethernet aliases from dtsi (2018-10-09 13:40:28
> -0500)
>
> ----------------------------------------------------------------
> SoCFPGA DTS updates for v4.20, part 3
> - Add ethernet aliases for Stratix10
> - Move ethernet aliases from socfpga dtsi
> - Correct system manager register size for Stratix10
> - Correct SDRAM node address for Arria10


Pulled into next/dt, thanks!

      Arnd
