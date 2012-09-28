From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2012 09:22:45 +0200
Subject: [PATCH 2/6] pinctrl: sirf: add missing pins to pinctrl list
In-Reply-To: <1348739643-21105-1-git-send-email-Barry.Song@csr.com>
References: <1348739643-21105-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdYE+GvH4cEwZSWzz3X7VGL2roBFApXTU8h+8PAmALTR2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 11:54 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> We always use pinctrl_request_gpio() to get GPIO, If we don't have these
> missing pins in the pin list, gpio_request and related operations will fail
> for them.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Applied, thanks!
Linus Walleij
