From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Dec 2017 10:19:55 +0100
Subject: [PATCH 1/2] pinctrl/nomadik/abx500: Delete an error message for a
 failed memory allocation in abx500_gpio_probe()
In-Reply-To: <1fa81c02-0b51-16d1-b713-971f7f44eb31@users.sourceforge.net>
References: <e5be1da7-460d-a47d-59b8-c1902907f5a4@users.sourceforge.net>
 <1fa81c02-0b51-16d1-b713-971f7f44eb31@users.sourceforge.net>
Message-ID: <CACRpkdbk5_NMRBD0DXOY1AF9tSVVqEySaendm4Q7X6UC2FUPQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 10:51 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 20 Dec 2017 10:12:56 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
