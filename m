From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Dec 2015 09:59:38 +0100
Subject: [PATCH] pinctrl: qcom: qdf2xxx: improve error checking and
 reporting
In-Reply-To: <1447171030-15056-1-git-send-email-timur@codeaurora.org>
References: <1447171030-15056-1-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkdbuiW34i+iZdujw4-sjrAY6K09BoVPxfGYsJsm4Cc6+Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 4:57 PM, Timur Tabi <timur@codeaurora.org> wrote:

> The driver doesn't report an error message if the ACPI tables are missing
> the num-gpios property (which indicates how many GPIOs there are on this
> SOC), and it didn't check to ensure that the mallocs didn't fail.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Patch applied with Bj?rn's review tag.

Yours,
Linus Walleij
