From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Jan 2014 15:02:23 +0100
Subject: [PATCH] ARM: ux500: Enable system suspend with WFI support
In-Reply-To: <1387378777-7639-1-git-send-email-ulf.hansson@linaro.org>
References: <1387378777-7639-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdZ+E-BE5WsPa5HLL56riC-BOFp5QxUM+Tp5ZTu-m+KuuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 3:59 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> When building for CONFIG_SUSPEND, add the platform suspend callbacks
> to enable system suspend for ux500.
>
> At this initial step, only WFI state is supported, which is reached
> for both PM_SUSPEND_MEM and PM_SUSPEND_STANDBY.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied.

Yours,
Linus Walleij
