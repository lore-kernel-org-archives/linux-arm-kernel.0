From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 18:37:07 +0100
Subject: [PATCH v5 2/5] dt-bindings: Add pinctrl bindings for
 mt65xx/mt81xx.
In-Reply-To: <CABuKBeL0y4OrLCtyV_n0eVsncpo7vT0ZentGC-ZW9YzBYDa1Qw@mail.gmail.com>
References: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
 <1421818097-9281-3-git-send-email-hongzhou.yang@mediatek.com>
 <CACRpkdYASTGTiiAF6EA=OCqYepdStf4UO9_qWGg6ACyd8=CaHw@mail.gmail.com>
 <CABuKBeL0y4OrLCtyV_n0eVsncpo7vT0ZentGC-ZW9YzBYDa1Qw@mail.gmail.com>
Message-ID: <CACRpkdZq-UA2K8dLjcVR1-ttxdHJRVZHPfjEigKZtMHY+wQ5YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 8, 2015 at 9:16 AM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> Hi Linus,
>
> 2015-02-10 9:01 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Wed, Jan 21, 2015 at 1:28 PM, Hongzhou Yang
>> <hongzhou.yang@mediatek.com> wrote:
>>
>>> From: Hongzhou Yang <hongzhou.yang@mediatek.com>
>>>
>>> Add devicetree bindings for Mediatek SoC pinctrl driver.
>>>
>>> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
>>
>> OK applied this patch for v3.21 now, relying on Sascha's ACK.
>
> I can see the the pinctrl driver parts in your tree repository [0],
> but not in linux-next.
> Do think of merging them in the next merge window?

Oops too stressed just forgot to merge them into my devel
branch.

Merged now. Will push from devel to for-next when the
zeroday builders say it all compiles.

Yours,
Linus Walleij
