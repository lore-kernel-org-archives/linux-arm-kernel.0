From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 Jul 2015 18:15:46 +0200
Subject: [GIT PULL] ARM: mediatek: arm64 updates for v4.2
In-Reply-To: <CABuKBeK=TQ1CQx4Co2m5p9xri4oBGMKynJL+9evm3xaTjvr8FQ@mail.gmail.com>
References: <CABuKBeK=TQ1CQx4Co2m5p9xri4oBGMKynJL+9evm3xaTjvr8FQ@mail.gmail.com>
Message-ID: <20150728161546.GA16690@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Tue, Jul 28, 2015 at 02:06:30PM +0200, Matthias Brugger wrote:
> Hi all,
> 
> Please take the following changes into account.
> 
> Thanks,
> Matthias
> 
> ---
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/mbgg/linux-mediatek.git tags/v4.2-next-arm64
> 
> for you to fetch changes up to e26945245e414eff42ee1ffeaedf198911bf1d77:
> 
>   arm64: dts: mediatek: add mt6795 support (2015-07-23 19:55:55 +0200)
> 
> ----------------------------------------------------------------
> - arm64: dts: mediatek: add mt6795 support
> - Document: DT: Add bindings for mediatek MT6795 SoC Platform
> - arm64: dts: mediatek: Add MT8173 MMC dts
> - arm64: dts: mt8173: Add afe device node
> - arm64: dts: mt8173-evb: Add PMIC support
> - dts: mt8173-evb: Add da9211 to i2c1
> - ARM: dts: mt8173: support arm64 cpuidle-dt
> - ARM64: MediaTek MT8173: Add SCPSYS device node
> - arm64: dts: mt8173: Add I2C device node
> - arm64: dts: mt8173: Add watchdog device node
> - arm64: dts: mt8173: Add PMIC wrapper device node
> - arm64: dts: mt8173: Use real clock for UARTs
> - arm64: dts: mt8173: Add clock controller device nodes
> 

Merged, but please write a descriptive tag message in the future instead of
just listing the patches. A brief overview of what's in the branch is a lot
more useful, since the list of patches makes it into the merge commit anyway.


Thanks,


-Olof
