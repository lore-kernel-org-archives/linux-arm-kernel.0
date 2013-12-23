From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Dec 2013 18:20:20 +0100
Subject: [PATCH 1/2] clk: versatile: pass a name to ICST clock provider
In-Reply-To: <CACRpkdYw-cjsJWd85_O=ZFOG1oawZU1cuEzZLyCLj6Z49+2fNw@mail.gmail.com>
References: <1385326732-16406-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdYw-cjsJWd85_O=ZFOG1oawZU1cuEzZLyCLj6Z49+2fNw@mail.gmail.com>
Message-ID: <CACRpkdaGLhm+3gNtddiU0TKkCDXEBAhp6SrJAw7571gpcEOnaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 11:14 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Sun, Nov 24, 2013 at 9:58 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> When we have more than one of these clocks in a system (such as
>> on the IM-PD1) we need a mechanism to pass a name for the clock.
>> Refactor to add this as an argument.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Hi Mike, I'd like an ACK for this if you're OK with it, so I
>> can take it through the ARM SoC tree with the rest of the
>> Integrator patches.
>
> Mike, ping on this. I want to prep a pull request...

Ping on this again.

Yours,
Linus Walleij
