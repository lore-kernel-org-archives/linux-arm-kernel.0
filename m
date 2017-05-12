From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 May 2017 11:09:42 +0200
Subject: [PATCH v3] pinctrl: mediatek: reuse pinctrl driver for mt7623
In-Reply-To: <1493625274-3909-1-git-send-email-sean.wang@mediatek.com>
References: <1493625274-3909-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <CACRpkdZ78Qc7ABHa7f58T0SEZ1OCcv=YOPX8305Sh3tQKXFCVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 1, 2017 at 9:54 AM,  <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> mt7623 pinctrl hardware can be compatible with mt2701 driver,
> so the patch lets the pinctrl on mt7623 SoC reuse the driver
> and deletes those redundant ones.
>
> Cc: John Crispin <john@phrozen.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Execllent, patch applied with John's and Matthias' ACK/Review tags
for v4.13.

Yours,
Linus Walleij
