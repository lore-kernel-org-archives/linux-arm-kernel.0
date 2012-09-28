From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2012 09:24:15 +0200
Subject: [PATCH 4/6] pinctrl: sirf: initialize the irq_chip pointer of
 pinctrl_gpio_range
In-Reply-To: <1348739746-21184-1-git-send-email-Barry.Song@csr.com>
References: <1348739746-21184-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdbWxbE+Yjr7NW6aDC7MxEAUnsURSmaHbZYnw+QNkeNFAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 11:55 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> This patch initializes the optional irq_chip pointer gc in sirfsoc
> pinctrl_gpio_range.
>
> Signed-off-by: Baohua Song <Baohua.Song@csr.com>

Applied, thanks!
Linus Walleij
