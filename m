From: axel.lin@ingics.com (Axel Lin)
Date: Thu, 28 May 2015 09:11:43 +0800
Subject: [PATCH 2/2] pinctrl: mediatek: Fix pinctrl register irq fail bug.
In-Reply-To: <1432719835-18939-3-git-send-email-hongzhou.yang@mediatek.com>
References: <1432719835-18939-1-git-send-email-hongzhou.yang@mediatek.com>
 <1432719835-18939-3-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CAFRkauDrWCme5WDxsEW-HSGrNmJRVftVBP6qPLq3Lux-09BHbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-27 17:43 GMT+08:00 Hongzhou Yang <hongzhou.yang@mediatek.com>:
> Since mt6397 is no need to support interrupt controller,
> I judged "interrupt-controller" property to skip it last patch.
> But the if judgement should on the contrary, this is a bug.
>
> And find of_property_read_bool is better for this case.
> So using of_property_read_bool instead of of_find_property.
>
> Also fix bug of misuse pointer.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
