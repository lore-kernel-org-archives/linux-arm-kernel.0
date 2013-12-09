From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Dec 2013 09:30:38 +0100
Subject: [PATCH][RESEND] ARM: misc: remove deprecated IRQF_DISABLED
In-Reply-To: <1386565230-19228-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1381550411-5824-1-git-send-email-michael.opdenacker@free-electrons.com>
 <1386565230-19228-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <CACRpkdb5EchUkdA4vUnyaWp5AS2b1p6UNcA9emwivDTxQzPzuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 9, 2013 at 6:00 AM, Michael Opdenacker
<michael.opdenacker@free-electrons.com> wrote:

> This patch proposes to remove the use of the IRQF_DISABLED flag
> from miscellaneous code in mach-xxx and plat-xxx
>
> This flag is a NOOP since 2.6.35 and it will be removed one day.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
