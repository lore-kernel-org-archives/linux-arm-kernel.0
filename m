From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 17:32:22 -0800
Subject: [GIT PULL 2/2] Broadcom devicetree-arm64 changes for 4.11
In-Reply-To: <20170118012931.10964-2-f.fainelli@gmail.com>
References: <20170118012931.10964-1-f.fainelli@gmail.com>
 <20170118012931.10964-2-f.fainelli@gmail.com>
Message-ID: <1c3325d4-dfcc-4723-89be-94d0adc2f3f3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 05:29 PM, Florian Fainelli wrote:
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

Forgot to mention that, but this is against v4.10-rc2, because v4.10-rc1
just was not building on ARM64, thanks!

> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.11/devicetree-arm64
> 
> for you to fetch changes up to 096fe8726e5df2975ed29e1ecd881fa54c80878b:
> 
>   arm64: dts: NS2: add support for XMC form factor (2017-01-03 15:23:22 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM64-based SoC Device Tree changes for
> 4.11, please pull the following changes:
> 
> - Jon adds Device Tree nodes for the GICv2m and PAXB/PAXC PCIe interfaces on
>   the Northstar 2 SoCs, he also enables PAXC on the Northstar 2 SVK reference
>   board. He also updates the reserved memory entry for the Nitro firmware,
>   required to get the on-chip NICs to work. Finally he adds support for the
>   BCM958712DxXMC reference board which is a subset of existing boards.
> 
> ----------------------------------------------------------------
> Jon Mason (4):
>       arm64: dts: NS2: enable GICv2m for PAXB/PAXC interfaces
>       arm64: dts: NS2: enable PAXC on NS2 SVK
>       arm64: dts: NS2: reserve memory for Nitro firmware
>       arm64: dts: NS2: add support for XMC form factor
> 
>  arch/arm64/boot/dts/broadcom/Makefile    |   2 +-
>  arch/arm64/boot/dts/broadcom/ns2-svk.dts |   4 +
>  arch/arm64/boot/dts/broadcom/ns2-xmc.dts | 191 +++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/broadcom/ns2.dtsi    | 123 ++++++++++++++++----
>  4 files changed, 295 insertions(+), 25 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/broadcom/ns2-xmc.dts
> 


-- 
Florian
