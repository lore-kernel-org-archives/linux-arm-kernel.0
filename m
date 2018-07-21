From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:27:38 -0700
Subject: [GIT PULL v2] arm64: zynqmp: Xilinx DT changes for v4.19
In-Reply-To: <c4c29579-8d05-a290-2d59-638170601849@monstr.eu>
References: <c4c29579-8d05-a290-2d59-638170601849@monstr.eu>
Message-ID: <20180721212738.kwsudmrsr64vqbv7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 09:52:41AM +0200, Michal Simek wrote:
> Hi,
> 
> Based on discussion with Olof all patches are using these prefixes.
> arm64: dts: zynqmp:
> 
> Please pull the following arm64 DT patches.
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
>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-v4.19-v2
> 
> for you to fetch changes up to 41ee3e3883056f216bc1044c7ab1c8477b3384ad:
> 
>   arm64: dts: zynqmp: Add support for Avnet Ultra96 rev1 board
> (2018-07-19 09:48:30 +0200)
> 
> ----------------------------------------------------------------
> arm: dts: zynqmp: DT changes for v4.19
> 
> - Use serdev for BT in zcu100
> - Remove ep108
> - Fix gpio-keys binding
> - Add suport for Ultra96

Merged, thanks!


-Olof
