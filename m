From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 15:39:04 +0200
Subject: [PATCH v2 1/5] pinctrl: pfc: r8a7790: add i2c0 muxing
In-Reply-To: <1395773789-17249-2-git-send-email-wsa@the-dreams.de>
References: <1395773789-17249-1-git-send-email-wsa@the-dreams.de>
 <1395773789-17249-2-git-send-email-wsa@the-dreams.de>
Message-ID: <CACRpkdZhz71tGBs_YQGTZDOjAJjyZdaDi6effD37=yNyNffXcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 7:56 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> From: Wolfram Sang <wsa@sang-engineering.com>
>
> Add the muxing for the last missing i2c rcar core. Fix the sorting for
> SH_PFC_PIN_NAMED while we are here.
>
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
> Change since V1:
>
> * sorted SH_PFC_PIN_NAMED pins

Patch applied with Laurent's ACK.

Yours,
Linus Walleij
