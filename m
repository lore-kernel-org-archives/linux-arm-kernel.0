From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Jan 2017 11:16:53 +0100
Subject: [PATCH 3/3 v4] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
In-Reply-To: <20170131100938.23660-1-linus.walleij@linaro.org>
References: <20170131100938.23660-1-linus.walleij@linaro.org>
Message-ID: <CACRpkdYDMH9A=ezPkANRQXcqceEqn-A+oL2TxHyNkjmSms5AOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 11:09 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> ChangeLog v3->v4:

Oh and I didn't remove the dev_info() where the driver brags about being
present.

I usually like to have those positive affirmations from my drivers so I know
they are there. Otherwise I can't tell the state when I for some reason
forgot to compile it in because of some Kconfig issue from the state
where it is silently present. This is especially helpful in mailed bug
reports where people post dmesg logs. Then I can see "aha at least it
probed".

It's not super-important, feel free to edit it out when applying if you
totally hate it, I won't hold it against you :)

Yours,
Linus Walleij
