From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 16:39:30 -0800
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.9
In-Reply-To: <20161115211333.oqvxfjxxudfkdq7j@lukather>
References: <20161115211333.oqvxfjxxudfkdq7j@lukather>
Message-ID: <20161119003930.GC15902@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 10:13:33PM +0100, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Here are our changes for arm64 DT for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt64-for-4.10
> 
> for you to fetch changes up to 4e3886081848b7ea16452a92c4324acaab644d49:
> 
>   arm64: dts: add Pine64 support (2016-11-03 09:08:24 +0100)
> 
> ----------------------------------------------------------------
> Allwinner arm64 DT changes for 4.10
> 
> Support for the Allwinner A64, their first armv8 SoC.
> 
> ----------------------------------------------------------------
> Andre Przywara (3):
>       arm64: dts: add Allwinner A64 SoC .dtsi
>       Documentation: devicetree: add vendor prefix for Pine64
>       arm64: dts: add Pine64 support

Hi,

Merged the branch, but please use "arm64: dts: allwinner: <..>" as patch
prefix in the future. Thanks!


-Olof
