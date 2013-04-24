From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 25 Apr 2013 10:39:28 +1200
Subject: [PATCH 0/3] dts: v8500: Cleanups for 3.10
In-Reply-To: <1366781902-13025-1-git-send-email-linux@prisktech.co.nz>
References: <1366781902-13025-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <51785F20.704@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/13 17:38, Tony Prisk wrote:
> Arnd, Olof,
>
> This is probably a bit late for 3.10 now but its just a bunch of cleanups for
> the arch-vt8500 devicetree SoC and board files, and the addition of a new
> dts for the VIA APC8750.
>
> Regards
> Tony P
>
> Tony Prisk (3):
>    dts: vt8500: Fix invalid/missing cpu nodes for soc files.
>    dts: vt8500: Add devicetree support for WM8750 SoC and APC8750 board
>    dts: vt8500: Update serial nodes and disable by default in SoC files
>
>   arch/arm/boot/dts/Makefile           |    1 +
>   arch/arm/boot/dts/vt8500-bv07.dts    |    4 +
>   arch/arm/boot/dts/vt8500.dtsi        |   29 ++-
>   arch/arm/boot/dts/wm8505-ref.dts     |    4 +
>   arch/arm/boot/dts/wm8505.dtsi        |   35 +++-
>   arch/arm/boot/dts/wm8650-mid.dts     |    4 +
>   arch/arm/boot/dts/wm8650.dtsi        |   21 +-
>   arch/arm/boot/dts/wm8750-apc8750.dts |   30 +++
>   arch/arm/boot/dts/wm8750.dtsi        |  355 ++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/wm8850-w70v2.dts   |    4 +
>   arch/arm/boot/dts/wm8850.dtsi        |   23 ++-
>   11 files changed, 492 insertions(+), 18 deletions(-)
>   create mode 100644 arch/arm/boot/dts/wm8750-apc8750.dts
>   create mode 100644 arch/arm/boot/dts/wm8750.dtsi
>
Don't worry about this patch series - it looks like we are going back to 
926ejs (rather than changing to 926) so I will send out another request 
after the merge window.

Regards
Tony P
