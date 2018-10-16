From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Oct 2018 09:44:13 +0200
Subject: [PATCH] dt-bindings: pinctrl: bcm4708-pinmux: improve example
 binding
In-Reply-To: <20181015093013.31651-1-zajec5@gmail.com>
References: <20181015093013.31651-1-zajec5@gmail.com>
Message-ID: <CACRpkdb1MjvaPx1kmGB_53w79-u-8QW_yZxcMD27sepdnP1XmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 11:30 AM Rafa? Mi?ecki <zajec5@gmail.com> wrote:

> From: Rafa? Mi?ecki <rafal@milecki.pl>
>
> Broadcom SoC pins are controlled using CRU ("Clock and Reset Unit" or
> "Central Resource Unit") registers. There are more CRU registers and
> functions so CRU should be represented as a separated block in DT.
>
> Moreover CRU is a sub-block of DMU ("Device Management Unit") so that
> one should also get its own node.
>
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Patch applied. (I guess it answers my question with "let's fix this in-tree").

Yours,
Linus Walleij
