From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Jun 2012 10:09:18 -0300
Subject: [PATCH] serial/amba-pl011: move custom pin control to driver
In-Reply-To: <CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
 <CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
Message-ID: <CAOMZO5DoO32LZyZAqrY=ut5HN=bEf7UgAhVkRBwZzrexeTKOXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Mon, Jun 25, 2012 at 8:31 AM, viresh kumar <viresh.kumar@linaro.org> wrote:

> What is expected from Platforms to handle this? AFAICR, we haven't
> done anything special
> to bind a pinctrl node to a struct dev for uart.

Does using "pinctrl_provide_dummies()" fix this problem?
