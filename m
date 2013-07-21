From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Jul 2013 00:53:52 +0200
Subject: [PATCH 3/5] arm/dts: sirf: fix the pingroup name mismatch between
 drivers and dts
In-Reply-To: <1372924529-5519-3-git-send-email-Baohua.Song@csr.com>
References: <1372924529-5519-1-git-send-email-Baohua.Song@csr.com>
 <1372924529-5519-3-git-send-email-Baohua.Song@csr.com>
Message-ID: <CACRpkdYNFzP7vhO-fRXsnQR2dQh9su6M5z-Wcwq7BxEV5ep=OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 4, 2013 at 9:55 AM, Barry Song <Baohua.Song@csr.com> wrote:

> in drivers/pinctrl/sirf, pingroup name is cko0 and cko1, but in dts, they
> are cko0 and cko1_rst. this patch fixes the error in dts.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Applied.

Yours,
Linus Walleij
