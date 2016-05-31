From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2016 12:51:39 +0200
Subject: [PATCH 12/17] pinctrl: uniphier: support pin configuration for
 dedicated pins
In-Reply-To: <1464681923-7469-13-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
 <1464681923-7469-13-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdY9wRMJddR+yEqqCRwjvgnXtkiVb9bkvv1+-ugq1V7-Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 10:05 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> PH1-LD4 and PH1-sLD8 SoCs have pins that support pin configuration
> (pin biasing, drive strength control), but not pin-muxing.
>
> Allow to fill the mux value table with -1 for those pins; pins with
> mux value -1 will be skipped in the pin-mux set function.  The mux
> value type should be changed from "unsigned" to "int" in order to
> accommodate -1 as a special case.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
