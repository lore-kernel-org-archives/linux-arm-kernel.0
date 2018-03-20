From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Mar 2018 01:58:11 +0100
Subject: [PATCH] net: gemini: fix memory leak
In-Reply-To: <1521441651-19753-1-git-send-email-igor.pylypiv@gmail.com>
References: <1521441651-19753-1-git-send-email-igor.pylypiv@gmail.com>
Message-ID: <CACRpkdak+-JrOy24iYvZNf0za6roVUsGUgVq4b28q5YPNy27tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 7:40 AM, Igor Pylypiv <igor.pylypiv@gmail.com> wrote:

> cppcheck report:
> [drivers/net/ethernet/cortina/gemini.c:543]: (error) Memory leak: skb_tab
>
> Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
