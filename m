From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Dec 2013 10:30:54 +0100
Subject: [PATCH V2 3/3] ARM: ux500: regulators: Remove dead code for
 SD-card regulator
In-Reply-To: <1386923493-9286-1-git-send-email-ulf.hansson@linaro.org>
References: <1386923493-9286-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdY+-6PvRYPHU5KBTO2uZu2XwMTgj=j+dMpX6V949dGWyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 9:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The signal-voltage regulator is handled through a gpio regulator
> configured in DT. Remove the old dead code.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This v2 version applied to the ux500-devicetree branch.

Yours,
Linus Walleij
