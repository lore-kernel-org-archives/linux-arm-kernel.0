From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 00:09:35 +0200
Subject: [PATCH v4 6/7] dt-binding: ARM: add pinctrl binding docs for
 Marvell Berlin2 SoCs
In-Reply-To: <1400520995-27365-7-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1400520995-27365-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1400520995-27365-7-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdbP++c+3LPOZ2LPbuEuxQorvYv0atROU_oD=uu4Nzyy7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 7:36 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> From: Antoine Tenart <antoine.tenart@free-electrons.com>
>
> Add pin control binding documentation to the SoC binding documentaion
> as pinctrl is part of chip/system control registers. The documentation
> also explains how to configure this group based controller.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Changelog:
> v3->v4:
> - move documentation of an exclusive pinctrl node to the Berlin SoC
>   binding documentation of chip/system control nodes instead.
> - remove "marvell," prefix from pinctrl function/groups property

This patch does not apply to my tree, obviously there are dependencies.

Take it wherever it works:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
