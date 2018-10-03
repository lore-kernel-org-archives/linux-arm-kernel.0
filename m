From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 3 Oct 2018 12:39:12 +0900
Subject: [PATCH 1/4] ARM: dts: uniphier: Add USB3 controller nodes
In-Reply-To: <1538478722-20351-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1538478722-20351-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1538478722-20351-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNAQjXkD_j3WO=SR=5708f=C7tmcZUc9ryZ5mXnMnKujmZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2018 at 8:12 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Add USB3 controller nodes including usb-core, resets, regulator, ss-phy
> and hs-phy. This supports for Pro4, PXs2 and the boards.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  arch/arm/boot/dts/uniphier-pro4-ace.dts    |   8 ++
>  arch/arm/boot/dts/uniphier-pro4-ref.dts    |   8 ++
>  arch/arm/boot/dts/uniphier-pro4.dtsi       |  94 +++++++++++++++
>  arch/arm/boot/dts/uniphier-pxs2-gentil.dts |   8 ++
>  arch/arm/boot/dts/uniphier-pxs2-vodka.dts  |   4 +
>  arch/arm/boot/dts/uniphier-pxs2.dtsi       | 180 +++++++++++++++++++++++++++++
>  6 files changed, 302 insertions(+)


I will enable this on uniphier-ld6b-ref.dts
and uniphier-pro4-sanji.dts as well
when I pick up this series.


-- 
Best Regards
Masahiro Yamada
