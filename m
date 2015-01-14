From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Jan 2015 14:01:39 +0100
Subject: [PATCH 3/3] gpio: sx150x: add dts support for sx150x driver
In-Reply-To: <CAGsJ_4xrTt1+6E-VhGb7PMY_6PHVK-e1nhip1SUHmWJcL4fQGg@mail.gmail.com>
References: <1417695130-5712-1-git-send-email-21cnbao@gmail.com>
 <1417695130-5712-3-git-send-email-21cnbao@gmail.com>
 <CACRpkdaeSpvS=k6F-hjyQfGDZdWgckwRjvYwhnQk1NnAhKLJJw@mail.gmail.com>
 <CAGsJ_4xrTt1+6E-VhGb7PMY_6PHVK-e1nhip1SUHmWJcL4fQGg@mail.gmail.com>
Message-ID: <CACRpkdbhoOWMCtrRw9fgD1PeF69TsMwzWspivY0cW_k8qR0saQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 7:02 PM, Barry Song <21cnbao@gmail.com> wrote:
> 2015-01-09 18:02 GMT+08:00 Linus Walleij <linus.walleij@linaro.org>:

>> Maybe I'm overzealous so that this would require implenenting
>> a whole lot of pin control stuff and move the driver to drivers/pinctrl,
>> but I won't let it go without a discussion first.
>
> my suggestion is we split this patch into two, the first one adds the
> basic gpio dt support, then we consider the pin configuration issue.

OK.

Yours,
Linus Walleij
