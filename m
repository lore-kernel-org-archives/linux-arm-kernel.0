From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 13:49:23 +0100
Subject: [PATCH 2/3] pinctrl: nsp: add pinmux driver support for Broadcom
 NSP SoC
In-Reply-To: <1448042245-25702-1-git-send-email-yrdreddy@broadcom.com>
References: <1448042245-25702-1-git-send-email-yrdreddy@broadcom.com>
Message-ID: <CACRpkdZ=vyPSiPCUppfDWC9OShqfe-BRvB5QjU1AZmbDbYvsZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 6:57 PM, Yendapally Reddy Dhananjaya Reddy
<yrdreddy@broadcom.com> wrote:

> This adds the initial support of the Broadcom NSP pinmux driver.
>
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>

So what does Ray and Stephen say about this?

Is the hardware unique enough to warrant its own driver?

Or should it utilize/extend one of the existing Broadcom
drivers?

Yours,
Linus Walleij
