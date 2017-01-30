From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 17:30:37 -0800
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.11
In-Reply-To: <5888D846.5040504@hisilicon.com>
References: <5888D846.5040504@hisilicon.com>
Message-ID: <20170130013037.GF3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 04:54:30PM +0000, Wei Xu wrote:
> Hi Arnd, Hi Olof, Hi Kevin,
> 
> Please help to pull the following changes.
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:
> 
>   Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.11
> 
> for you to fetch changes up to 0f84832fb8f92b06f5e9b33d56836acb340dac53:
> 
>   arm64: defconfig: Enable NUMA and NUMA_BALANCING (2017-01-20 16:14:26 +0000)
> 
> ----------------------------------------------------------------
> ARM64: hisilicon: defconfig updates for 4.11
> 
> - Enable ARM_SMMU_V3 in the arm64 defconfig
> - Enable NUMA and NUMA_BALANCING in the arm64 defconfig
> 
> ----------------------------------------------------------------
> Kefeng Wang (1):
>       arm64: defconfig: Enable NUMA and NUMA_BALANCING
> 
> Zhou Wang (1):
>       arm64: defconfig: enable SMMUv3 config
> 
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Merged, thanks!


-Olof
