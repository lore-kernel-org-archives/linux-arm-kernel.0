From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jul 2018 22:07:28 +0200
Subject: [GIT PULL] ARM: mediatek: 64-bit DT updates for v4.19
In-Reply-To: <3d66f9bc-48b5-00f2-c8eb-838f0ded5d90@gmail.com>
References: <02b45906-ace0-bf49-7ccc-c9827e919d7c@gmail.com>
 <3d66f9bc-48b5-00f2-c8eb-838f0ded5d90@gmail.com>
Message-ID: <CAOesGMjADOD77fSmFbughh8eiGTnpgMCggAkndAa2Rpzy9-nag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 10:19 AM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> Hi Olof,
> Hi Arnd,
>
> This is the second attempt to send the pull request, as in the first one I sent
> the branch instead of the tag.
>
> Please have a look.
> Regards,
> Matthias
>
> ---
>
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
> tags/v4.18-next-dts64
>
> for you to fetch changes up to a873996921296ad74941017bf00884f14e10dffd:
>
>   arm64: dts: Add Mediatek X20 Development Board support (2018-07-20 17:46:46 +0200)
>
> ----------------------------------------------------------------
> - mt7622:
> - add EINT support
> - add gpio-ranges property to pinctrl
> - add earlycon to rfb1 to find boot errros more easily
> - fix uart clock
> - add iommu and smi bindings
>
> - mt6797:
> - add support for the 96 board x20 development board
>
> - fix cooling-cells of mt7622 and mt8173

Merged, thanks!


-Olof
