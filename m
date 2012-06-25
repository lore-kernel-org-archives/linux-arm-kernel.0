From: viresh.kumar@linaro.org (viresh kumar)
Date: Mon, 25 Jun 2012 14:17:16 +0100
Subject: [PATCH] serial/amba-pl011: move custom pin control to driver
In-Reply-To: <CAOMZO5DoO32LZyZAqrY=ut5HN=bEf7UgAhVkRBwZzrexeTKOXA@mail.gmail.com>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
 <CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
 <CAOMZO5DoO32LZyZAqrY=ut5HN=bEf7UgAhVkRBwZzrexeTKOXA@mail.gmail.com>
Message-ID: <CAOh2x=m0PAtaJszeYzL0cYLMYAyDUHgEoP=fGx1qxa_5FHTxHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 2:09 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Jun 25, 2012 at 8:31 AM, viresh kumar <viresh.kumar@linaro.org> wrote:
>> What is expected from Platforms to handle this? AFAICR, we haven't
>> done anything special
>> to bind a pinctrl node to a struct dev for uart.
>
> Does using "pinctrl_provide_dummies()" fix this problem?

I have seen imx patches using this stuff and probably it will fix our
problem. We are
checking and will come back tomorrow.

--
viresh
