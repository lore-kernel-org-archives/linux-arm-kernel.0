From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Jan 2015 10:59:08 +0100
Subject: [PATCH v4 1/3] pinctrl: add driver for Amlogic Meson SoCs
In-Reply-To: <1421518516-26976-2-git-send-email-b.galvani@gmail.com>
References: <1421518516-26976-1-git-send-email-b.galvani@gmail.com>
 <1421518516-26976-2-git-send-email-b.galvani@gmail.com>
Message-ID: <CACRpkdZ6CX1XePa0sOY-0B9He9jYPNLqUtkk3LEGeT6eSQW9ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 7:15 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:

> This is a driver for the pinmux and GPIO controller available in
> Amlogic Meson SoCs. It currently supports only Meson8, however the
> common code should be generic enough to work also for other SoCs after
> having defined the proper set of functions and groups.
>
> GPIO interrupts are not supported at the moment due to lack of
> documentation.
>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

Patch applied. Great work Beniamino!

Yours,
Linus Walleij
