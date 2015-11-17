From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Nov 2015 14:33:49 +0100
Subject: [PATCH] pinctrl: qcom: qdf2xxx: improve error checking and
 reporting
In-Reply-To: <1447171030-15056-1-git-send-email-timur@codeaurora.org>
References: <1447171030-15056-1-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkdb4Ck4XCUEKX7TEgCg8723vZA-sxqmd753O1q9uTBszfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 4:57 PM, Timur Tabi <timur@codeaurora.org> wrote:

> The driver doesn't report an error message if the ACPI tables are missing
> the num-gpios property (which indicates how many GPIOs there are on this
> SOC), and it didn't check to ensure that the mallocs didn't fail.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Waiting for Bj?rn's ACK on this.

And I suspect Arnd would be interested to know if you are doing
ACPI on something that is certainly not a server-class hardware.
Because you shouldn't.

Yours,
Linus Walleij
