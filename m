From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Jul 2016 23:24:31 +0200
Subject: [PATCH 3/7] arm: mach-u300: regulator: add missing of_node_put
 after calling of_parse_phandle
In-Reply-To: <1467366121-14120-4-git-send-email-peter.chen@nxp.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
 <1467366121-14120-4-git-send-email-peter.chen@nxp.com>
Message-ID: <CACRpkdYMn94brCXUzS2b+4GBTx7WVhKririVzmHjjeVb9CC7NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 1, 2016 at 11:41 AM, Peter Chen <peter.chen@nxp.com> wrote:

> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
