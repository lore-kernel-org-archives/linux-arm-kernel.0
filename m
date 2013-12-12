From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 15:45:17 +0100
Subject: [PATCH 3/3] pinctrl: at91: implement at91_pinconf_dbg_show
In-Reply-To: <1386421734-10240-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1386421734-10240-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1386421734-10240-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CACRpkdbAmPxVdQ_hVQSQpgVu324Jg9D6FYj-OyfsorPP2zzdLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 7, 2013 at 2:08 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> This allows to get the pin configuration by using debugfs. On my system:
>  # cat /sys/kernel/debug/pinctrl/pinctrl.3/pinconf-pins
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

This is a more invasive patch so I prefer if Laurent ACK this before
I apply it.

Yours,
Linus Walleij
