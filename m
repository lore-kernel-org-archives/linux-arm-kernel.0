From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 11:10:06 +0200
Subject: [PATCH 13/34] pinctrl: mvebu: armada-39x: normalize SDIO pin
 naming
In-Reply-To: <1433868446-11028-14-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-14-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdb8nonVUJpR7zf3iNapOf1s+HBYAdcWLc4zpt4y1Krv5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> In order to be consistent with the datasheet and some other SoCs, this
> commit renames the SDIO pins of the Armada 39x from "sd" to "sd0".
>
> While this changes the DT binding, this is not a problem since Armada
> 39x is a brand new SoC which isn't used in production yet (so now is
> the right time to fix such things).
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
