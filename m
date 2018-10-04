From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 4 Oct 2018 09:49:31 +0900
Subject: [PATCH 1/4] ARM: dts: uniphier: Add USB3 controller nodes
In-Reply-To: <1538478722-20351-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1538478722-20351-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1538478722-20351-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNATgBVDt3g4OfxF4kj5w-_u3Y4Yd9-FjC3wseijoR12O0g@mail.gmail.com>
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


Series, applied.

Thanks.


-- 
Best Regards
Masahiro Yamada
