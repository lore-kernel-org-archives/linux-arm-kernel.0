From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 May 2017 15:58:54 +0200
Subject: [PATCH 7/8 v2] clocksource/drivers/fttmr010: Merge Moxa into
 FTTMR010
In-Reply-To: <20170518201705.28790-7-linus.walleij@linaro.org>
References: <20170518201705.28790-1-linus.walleij@linaro.org>
 <20170518201705.28790-7-linus.walleij@linaro.org>
Message-ID: <CACRpkdZE-kG9ChQSsdbNDNUYgoAq3ZNHSR74GfG25XwQeKoV+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 10:17 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> This merges the Moxa Art timer driver into the Faraday FTTMR010
> driver and replaces all Kconfig symbols to use the Faraday
> driver instead. We are now so similar that the drivers can
> be merged by just adding a few lines to the Faraday timer.

OK Daniel, the series is tested clear by Joel and Jonas,
feel free to merge these patches up to and including this #7
when you feel they look good.

Patch #8 I will send to the ARM SoC people pronto.

Yours,
Linus Walleij
