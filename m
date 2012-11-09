From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Nov 2012 11:24:55 +0100
Subject: [PATCH 2/2] pinctrl/nomadik: make independent of prcmu driver
In-Reply-To: <509BE7C5.4030109@wwwdotorg.org>
References: <1352375742-29611-1-git-send-email-linus.walleij@stericsson.com>
 <509BE7C5.4030109@wwwdotorg.org>
Message-ID: <CACRpkdaBTjAuifBrZNOuXsrq-TQHQgns4cRF=-qYoqKVGxusdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2012 at 6:11 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> Do you actually need to store the run-time data in struct
> nmk_pinctrl_soc_data too? I would have expected all the soc_data
> pointers to remain const, and to store the runtime register pointer
> somewhere else, and perhaps pass it as a separate parameter to the
> relevant init functions; wouldn't that make the patch much smaller?

OK point taken, I'm sending a v2...

Yours,
Linus Walleij
