From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Apr 2017 09:29:53 +0200
Subject: [PATCH v2 1/2] pinctrl: meson: meson8b: fix the NAND DQS pins
In-Reply-To: <20170401135922.1288-2-martin.blumenstingl@googlemail.com>
References: <20170325184350.7677-1-martin.blumenstingl@googlemail.com>
 <20170401135922.1288-1-martin.blumenstingl@googlemail.com>
 <20170401135922.1288-2-martin.blumenstingl@googlemail.com>
Message-ID: <CACRpkdbc9BqTAo-KbqVdeJ5ZS1K5ikepdvz_-ScjcX_sDvioPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 1, 2017 at 3:59 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> The nand_groups table uses different names for the NAND DQS pins than
> the GROUP() definition in meson8b_cbus_groups (nand_dqs_0 vs nand_dqs0).
> This prevents using the NAND DQS pins in the devicetree.
>
> Fix this by ensuring that the GROUP() definition and the
> meson8b_cbus_groups use the same name for these pins.
>
> Fixes: 0fefcb6876d0 ("pinctrl: Add support for Meson8b")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied with Kevin's ACK.

Yours,
Linus Walleij
