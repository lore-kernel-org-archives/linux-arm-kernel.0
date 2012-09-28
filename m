From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2012 09:25:13 +0200
Subject: [PATCH 5/6] pinctrl: sirf: add lost chained_irq_enter and exit in
 sirfsoc_gpio_handle_irq
In-Reply-To: <1348739770-21218-1-git-send-email-Barry.Song@csr.com>
References: <1348739770-21218-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdbfgPE4VoSrvTVnU=tWcgzdcBFqwR2WyE6T=5Pbitri=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 11:56 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> This patch fixes the chained irq hang issue, tested by DM9000 driver using
> GPIO0-3(irqnr=131) as the external IRQ on SiRFmarco:

Applied, thanks!
Linus Walleij
