From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jun 2011 10:17:51 +0200
Subject: [PATCH 1/2] amba pl011: workaround for uart registers lockup
In-Reply-To: <1307952693-25232-1-git-send-email-linus.walleij@stericsson.com>
References: <1307952693-25232-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <BANLkTikSEVCGGsjF_fTCNZsmjvGoic5u=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 10:11 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
>
> This workaround aims to break the deadlock situation
> which raises during continuous transfer of data for long
> duration over uart with hardware flow control. It is
> observed that CTS interrupt cannot be cleared in uart
> interrupt register (ICR). Hence further transfer over
> uart gets blocked.

Ping on this, Greg have you picked these two for the tty next tree?

Thanks,
Linus Walleij
