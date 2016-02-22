From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 22 Feb 2016 13:48:57 +0100
Subject: [GIT PULL] ARM: mediatek: dts updates for v4.6
In-Reply-To: <CABuKBeK+zT85Z695dBGO-0tU26w5LBJqS53aecdZYGZ6V0GPhA@mail.gmail.com>
References: <CABuKBeK+zT85Z695dBGO-0tU26w5LBJqS53aecdZYGZ6V0GPhA@mail.gmail.com>
Message-ID: <CABuKBe+8TkdnYX1pKLHkhRbYyAmhX9-QP=6oTOt73oQCR5NA7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2016-02-22 13:43 GMT+01:00 Matthias Brugger <matthias.bgg@gmail.com>:
> Hi Arnd and Olof,
>
> Please pull the following patches.
> As you can see from the description, this pull request includes some
> fixes. Only a few developer have access to a Mediatek HW at the
> moment. Therefore I didn't send the fixes to stable.
>
> If you want me to send the fixes for older kernel versions, please let me know.
>
> Thanks,
> Matthias
>
> ---
>
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
>
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
>
> are available in the git repository at:
>
>   https://github.com/mbgg/linux-mediatek.git tags/v4.5-next-dts64

As the tag name says, these pull request is for dts64 instead of dts,
as written in the subject.
I screwed it up, sorry.

Regards,
Matthias

>
> for you to fetch changes up to 3ea064b1e5adc263893ffdc3a11891c6d00d5e49:
>
>   ARM64: dts: Mediatek: mt8173-evb: fix access MMC fail issue
> (2016-02-19 11:05:09 +0100)
>
> ----------------------------------------------------------------
> Add nor-flash to mt8173 SoC.
> Add efuse device to mt1873 SoC.
> Fix power-domain issue mt8173-evb which uses older chip revision.
>
> ----------------------------------------------------------------
> Bayi Cheng (1):
>       arm64: dts: mt8173: Add nor flash node
>
> Eddie Huang (1):
>       ARM64: dts: Mediatek: mt8173-evb: fix access MMC fail issue
>
> andrew-ct.chen at mediatek.com (1):
>       dts: arm64: Add EFUSE device node
>
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  3 +++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)



-- 
motzblog.wordpress.com
