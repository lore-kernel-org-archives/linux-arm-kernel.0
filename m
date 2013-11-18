From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Nov 2013 23:46:55 +0100
Subject: [PATCH 6/8] gpio: twl4030: Fix passing of pdata in the device
 tree case
In-Reply-To: <20131118182724.GO10317@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-7-git-send-email-tony@atomide.com>
 <20131118182724.GO10317@atomide.com>
Message-ID: <CACRpkdZtA2rh5qe5Qs0OKjrChxHZV8MG=UUDdy9fb0Lvq2KtxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 7:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [131113 18:37]:
>> We still have some legacy code needing the callback functions
>> that won't work properly without platform data. To use platform
>> data for twl4030-gpio, we need to not trash the possible data.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: linux-gpio at vger.kernel.org
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>
>> If this looks OK, I'd like to merge this as a fix via arm-soc tree
>> along with the other patches in this series as my later patches
>> depend on patches in this series.
>
> Here's this one with a fix from Fengguang Wu to use struct assignment
> instead of memcpy folded in.

Looks allright:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
