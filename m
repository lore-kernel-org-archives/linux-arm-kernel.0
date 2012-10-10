From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 09:46:28 +0200
Subject: [PATCH 00/16] pinctrl: samsung: Usability and extensibiltiy
 improvements
In-Reply-To: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdbUmM2=vhjhCq_qN2v=8RUDeWV4b8A8oXXPE4e8Z9C7zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:

> This patch series is a work on improving usability and extensibiltiy of the
> pinctrl-samsung driver. It consists of three main parts:
>  - moving SoC-specific data to device tree
>  - converting the driver to use one GPIO chip and one IRQ domain per pin bank
>  - introducing generic wake-up interrupt capability description

So can you prepare a patch series which does all but the first
bullet to begin with, and a SoC-and register offset patch
on top of that as a separate series, because it is controversial?

I don't like that these two things are mingled together like this
in an all-or-nothing manner.

So I'm OK with a patch series for bulle (2) and (3) but not (1).

And I'd like to have Thomas A:s ACK on the series too.

Yours,
Linus Walleij
