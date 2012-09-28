From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2012 09:29:48 +0200
Subject: [PATCH 6/6] pinctrl: sirf: enable the driver support new
 SiRFmarco SoC
In-Reply-To: <1348739790-21253-1-git-send-email-Barry.Song@csr.com>
References: <1348739790-21253-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdYT2TZX8cchPk+H4LkdVXw861BBTn1dbnSJO-ZQVT5sdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 11:56 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> The driver supports old up SiRFprimaII SoCs, this patch makes it support
> the new SiRFmarco as well.
> SiRFmarco, as a SMP SoC, adds new SIRFSOC_GPIO_PAD_EN_CLR registers, to
> disable GPIO pad, we should write 1 to the corresponding bit in the new
> CLEAR register instead of writing 0 to SIRFSOC_GPIO_PAD_EN.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

This doesn't apply to my tree, you must have some other changes that
are not included in the patch set...

Can you pls try to generate and test the patch against the pinctrl tree?

I might apply it as per the "new driver" rule if I can convince myself that it
doesn't destabilize the current driver.

Yours,
Linus Walleij
