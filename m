From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Apr 2017 09:31:25 +0200
Subject: [PATCH v2 2/2] pinctrl: meson: meson8b: rename the NAND DQS pin
 definitions
In-Reply-To: <20170401135922.1288-3-martin.blumenstingl@googlemail.com>
References: <20170325184350.7677-1-martin.blumenstingl@googlemail.com>
 <20170401135922.1288-1-martin.blumenstingl@googlemail.com>
 <20170401135922.1288-3-martin.blumenstingl@googlemail.com>
Message-ID: <CACRpkdaHiDo5_NjfdEaqKyu+ZXrvrtuO7YLyv-wPvhAc2qfCgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 1, 2017 at 3:59 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> The NAND DQS pins are currently named nand_dqs_0 and nand_dqs_1.
> However, they both seem to have the same function, just exposed on
> different pins (unlike the ethernet TX pins for example, where there's
> eth_txd0..3 - all of these can be active at the same time as they are
> different data lines).
> Rename the NAND DQS pins to nand_dqs_15 and nand_dqs_18 to reflect that
> it's the same functionality just exposed on different pins (BOOT_15 and
> BOOT_18).
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied with Kevin's ACK.

Yours,
Linus Walleij
