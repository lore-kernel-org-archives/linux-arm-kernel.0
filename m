From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 12:53:23 -0800
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for
 v4.5
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <20151222205323.GR30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 11:29:43AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these third round of Renesas ARM based SoC DT updates for v4.5.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-dt2-for-v4.5,
> which you have already pulled.
> 
> 
> The following changes since commit c8d9fdbe2d648caaa510d45dc13eba2e9957140b:
> 
>   ARM: shmobile: sh73a0 dtsi: Add L2 cache-controller node (2015-11-25 10:42:38 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v4.5
> 
> for you to fetch changes up to d01c8bec91414f2110370dfcb9dd33fc0e573cee:
> 
>   ARM: shmobile: r8a779x: use SoC-specific usb-dmac compatibility strings (2015-12-17 10:10:54 +0900)

Merged, thanks.



> ----------------------------------------------------------------
> Geert Uytterhoeven (11):
>       ARM: shmobile: sh73a0: Add MSIOF clocks
>       ARM: shmobile: sh73a0: Add MSIOF device nodes
>       ARM: shmobile: bockw dts: Override #sound-dai-cells to zero
>       ARM: shmobile: koelsch dts: Add serial port config to chosen/stdout-path
>       ARM: shmobile: alt dts: Add serial port config to chosen/stdout-path
>       ARM: shmobile: ape6evm dts: Add serial port config to chosen/stdout-path
>       ARM: shmobile: bockw dts: Update console parameters
>       ARM: shmobile: gose dts: Add serial port config to chosen/stdout-path
>       ARM: shmobile: silk dts: Add serial port config to chosen/stdout-path
>       ARM: shmobile: porter dts: Add serial port config to chosen/stdout-path
>       ARM: shmobile: lager dts: Add serial port config to chosen/stdout-path
> 
> Kuninori Morimoto (1):
>       ARM: shmobile: r8a7778: tidyup #sound-dai-cells settings
> 
> Magnus Damm (4):
>       ARM: shmobile: r8a7790: IPMMU compat string SoC part number update
>       ARM: shmobile: r8a7791: IPMMU compat string SoC part number update
>       ARM: shmobile: r8a7793: IPMMU compat string SoC part number update
>       ARM: shmobile: r8a7794: IPMMU compat string SoC part number update
> 
> Sergei Shtylyov (2):
>       ARM: shmobile: r8a7791: add EtherAVB clock
>       ARM: shmobile: r8a7791: add EtherAVB DT support
> 
> Simon Horman (4):
>       ARM: shmobile: r8a7793: remove deprecated #gpio-range-cells
>       ARM: shmobile: r8a7793: Add missing serial devices to DT
>       ARM: shmobile: r8a7793: Describe DMA for the serial ports
>       ARM: shmobile: r8a779x: use SoC-specific usb-dmac compatibility strings
> 
> Wolfram Sang (3):
>       ARM: shmobile: r8a7790: dtsi: add internal delay for i2c IPs
>       ARM: shmobile: r8a7791: dtsi: add internal delay for i2c IPs
>       ARM: shmobile: r8a7794: dtsi: add internal delay for i2c IPs

Again, on ARM we use ARM: dts: <platform>: ...



-Olof
