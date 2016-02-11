From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 12 Feb 2016 00:27:40 +0100
Subject: [PATCH v3 5/5] arm: dts: Add pinctrl/GPIO/EINT node for mt2701
In-Reply-To: <CACRpkdbc-tNaeMzzX2riwUFPp0-XjVfvjuM6knWzVVwP89ECdA@mail.gmail.com>
References: <1451286546-5920-1-git-send-email-biao.huang@mediatek.com>
 <1451286546-5920-6-git-send-email-biao.huang@mediatek.com>
 <5685104D.7070008@gmail.com>
 <CACRpkdbc-tNaeMzzX2riwUFPp0-XjVfvjuM6knWzVVwP89ECdA@mail.gmail.com>
Message-ID: <56BD18EC.3090601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/01/16 11:14, Linus Walleij wrote:
> On Thu, Dec 31, 2015 at 12:23 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>> On 28/12/15 08:09, Biao Huang wrote:
>>>
>>> Add pinctrl and GPIO node to mt2701.dtsi
>>>
>>> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>>    arch/arm/boot/dts/mt2701.dtsi |   19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> Linus, will you take this patch through your branch?
>
> No I prefer anything in arch/arm/boot/dts/* to go in through
> the ARM SoC tree.
>
> It can usually be merged orthogonally anyways.
>
> I take Documenation/devicetree/bindings/* and patches
> to the driver itself in drivers/pinctrl/*
>
> Yours,
> Linus Walleij
>

Applied, thanks.
