From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 May 2018 09:36:08 +0200
Subject: [PATCH v1 1/7] dt-bindings: pinctrl: add external interrupt
 support to MT7622 pinctrl
In-Reply-To: <3898620ef606004aaddc332591ca467f56773029.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
 <3898620ef606004aaddc332591ca467f56773029.1526835466.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdbKwck2E3v+vr3freG1L5kSnfRc8Gti7jYtkqcuemK-fQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 7:01 PM,  <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Extend the capability of MT7622 pinctrl with adding EINT so that each
> GPIO can be used to notify CPU when a signal state is changing on the
> line as an external interrupt.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied with Rob's review tag.

Yours,
Linus Walleij
