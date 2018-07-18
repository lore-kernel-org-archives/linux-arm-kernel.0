From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jul 2018 08:00:24 -0700
Subject: [GIT PULL] arm64: zynqmp: Xilinx DT changes for v4.19
In-Reply-To: <a0dc4c86-7fe6-b9f6-2d57-b418061dbb3c@monstr.eu>
References: <a0dc4c86-7fe6-b9f6-2d57-b418061dbb3c@monstr.eu>
Message-ID: <CAOesGMhaVNmmsJStL8RXv_RP_yd7TSDdfTRUvnz+jx+7OY_O3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 7:14 AM, Michal Simek <monstr@monstr.eu> wrote:
> Hi,
>
> please pull the following arm64 DT patches.
>
> Thanks,
> Michal
>
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>
> are available in the git repository at:
>
>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-v4.19
>
> for you to fetch changes up to d287de28641beb953f7ab2bd6966b166ea5c6e99:
>
>   arm64: zynqmp: Add support for Avnet Ultra96 rev1 board (2018-07-17
> 16:41:09 +0200)
>
> ----------------------------------------------------------------
> arm: zynqmp: DT changes for v4.19
>
> - Use serdev for BT in zcu100
> - Remove ep108
> - Fix gpio-keys binding
> - Add suport for Ultra96
>
> ----------------------------------------------------------------
> Michal Simek (4):
>       arm64: zynqmp: Use serdev for zcu100 BT
>       arm64: zynqmp: Remove ep108 board
>       arm64: zynqmp: Remove #address/#size-cells from gpio-keys
>       arm64: zynqmp: Add support for Avnet Ultra96 rev1 board

Common style here is:

arm64: dts: zyncmp: <...>

Again, please respin and fix. We've been pretty lenient on this but
it's turning into the wild west. :)


-Olof
