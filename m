From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jul 2018 08:53:55 -0700
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.19
In-Reply-To: <5B4F60ED.2070106@hisilicon.com>
References: <5B4F60ED.2070106@hisilicon.com>
Message-ID: <CAOesGMgaqFeqqpcFxGvs-r3g-2WRYyhk=JLhWgp4gO41gXKTcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 8:46 AM, Wei Xu <xuwei5@hisilicon.com> wrote:
> Hi Olof, Hi Arnd,
>
> Please consider to pull the following changes.
> Thanks!
>
> Best Regards,
> Wei
>
> ---
>
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>
> are available in the Git repository at:
>
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.19
>
> for you to fetch changes up to cc4493faf494bb8af2324b1b7cabd1f1457a76ca:
>
>   arm64: defconfig: enable HiSilicon PMU driver (2018-07-17 14:06:16 +0100)
>
> ----------------------------------------------------------------
> ARM64: hisilicon: defconfig updates for 4.18
>
> - Enable uncore pmu for some hisilicon SoCs

Thanks, merged! Btw, for single patches like these, you can just git
send-email the patch to us too -- it's about the same amount of work
and fewer merge commits. But it's up to you.


-Olof
