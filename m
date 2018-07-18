From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jul 2018 07:58:06 -0700
Subject: [GIT PULL] arm: zynq: Xilinx DT changes for v4.19
In-Reply-To: <50ac449c-2196-0352-0352-1f761d321e61@xilinx.com>
References: <50ac449c-2196-0352-0352-1f761d321e61@xilinx.com>
Message-ID: <CAOesGMhvbj6cde2N+fG-ZBSF=gBNPa56x0M0GnKu8sk-yyRV-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 18, 2018 at 7:10 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> Hi,
>
> please pull the following patches.
>
> Thanks,
> Michal
>
>
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>
> are available in the git repository at:
>
>   https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-v4.19
>
> for you to fetch changes up to 7df89642f143d67a80605ea3fb7e53bcb95f6b39:
>
>   arm: zynq: Remove #address/#size-cells from gpio-keys (2018-07-17
> 16:57:29 +0200)
>
> ----------------------------------------------------------------
> arm: zynq: DT changes for v4.19
>
> - Add Z-turn board
> - Add mmc aliases
> - Fix model information
> - Sort out documentatio
> - Update Zybo Z7
> - Fix gpio-keys
>
> ----------------------------------------------------------------
> Anton Gerasimov (1):
>       arm: dts: zynq: Add support for Z-turn board
>
> Luis Araneda (9):
>       arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed
> boards
>       arm: dts: zynq: correct and improve the model property of dt files
>       dt-bindings: xilinx: zynq: Improve boards description
>       dt-bindings: xilinx: zynq: Sort entries alphabetically
>       dt-bindings: Move Paralella board to Xilinx
>       dt-bindings: xilinx: zynq: Add missing boards
>       arm: dts: zynq: Fix memory size on the Zybo Z7 board
>       arm: dts: zynq: Use gpio constants for the Zybo Z7 board
>       arm: dts: zynq: Add LEDs to the Zybo Z7 board
>
> Michal Simek (2):
>       arm: zynq: Add mmc alias for zc702/zc706/zed/zybo
>       arm: zynq: Remove #address/#size-cells from gpio-keys

We use "ARM: dts: <...>" as prefix on ARM. Please fix up and resubmit.


Thanks,

-Olof
