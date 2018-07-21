From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:28:56 -0700
Subject: [GIT PULL v2] arm64: dts: hisilicon dts updates for v4.19
In-Reply-To: <5B50630D.7060407@hisilicon.com>
References: <5B50630D.7060407@hisilicon.com>
Message-ID: <20180721212856.ekm6fiunfa3jflyk@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 11:08:13AM +0100, Wei Xu wrote:
> Hi Olof, Hi Arnd,
> 
> Please consider to pull the following changes.
> I rebased the pull on hisi-fixes-for-4.18 since there are
> some fixes for v4.18 have been merged.
> 
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit a30449eb3ac908f26b4bc963a58039a5f2725ffa:
> 
>   arm64: dts: hikey960: Define wl1837 power capabilities (2018-06-28 17:07:44 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.19v2
> 
> for you to fetch changes up to 4d4585c21f53c15a10c52b45e0392de79e07127e:
> 
>   arm64: dts: hisilicon: Add missing cooling device properties for CPUs (2018-07-17 13:56:45 +0100)
> 
> ----------------------------------------------------------------
> ARM64: DT: Hisilicon SoC DT updates for 4.19v2
> 
> - Tidy up MMC properties for hi3660
> - Remove keep-power-in-suspend on hikey and hikey960 to
>   avoid keeping wifi power during suspend and let the
>   user enable it if required
> - Update idle states for hikey960
> - Add missing cooling device properties for cpus on hi6220

Merged, thanks!


-Olof
