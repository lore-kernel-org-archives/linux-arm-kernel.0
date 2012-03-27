From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Mar 2012 09:07:22 +0200
Subject: [PATCH] amba-pl011: fix panic introduced by "clear pending
 interrupts"
In-Reply-To: <20120326203209.GA8182@mail.gnudd.com>
References: <20120326203209.GA8182@mail.gnudd.com>
Message-ID: <CACRpkdZXhJn241n8wMU8yUFwL7mpWrV3hP6C-_r_P1GGWgd_Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 10:32 PM, Alessandro Rubini <rubini@gnudd.com> wrote:

> patch 9b96fba, currently in linux-next, clears interrupts using
> uap->port.membase that has not been assigned. ?My x86 system,
> that uses a pci-to-amba bridge, panics with a message like:
>
> ? BUG: unable to handle kernel NULL pointer dereference at 00000038
> ? IP: [<c12c85ed>] pl011_probe+0x119/0x303
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Yep I know, already sent the remedy, just waiting for Greg to pick it up:
http://marc.info/?l=linux-serial&m=133235774423240&w=2

But thanks for the quick attention :-)

Yours,
Linus Walleij
