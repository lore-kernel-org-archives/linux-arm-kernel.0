From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Jun 2017 15:34:14 +0200
Subject: [PATCH 2/2 v4] clk: Add Gemini SoC clock controller
In-Reply-To: <20170601070208.GO20170@codeaurora.org>
References: <20170524082044.8473-1-linus.walleij@linaro.org>
 <20170601070208.GO20170@codeaurora.org>
Message-ID: <CACRpkdZv8MzXVecEXVdJ+P0MxVscYSy=MxC-yQAR0S4yQ6-rwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 1, 2017 at 9:02 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

>> +CLK_OF_DECLARE_DRIVER(gemini_cc, "cortina,gemini-syscon", gemini_cc_init);
>
> Is there a reason why this isn't a platform driver?

I can't get the platform to boot if I try, I guess because the console
UART needs the clock like super-early.

I fixed all the other issues, resending soon.

Yours,
Linus Walleij
