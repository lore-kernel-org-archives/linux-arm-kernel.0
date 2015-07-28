From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Jul 2015 14:10:52 +0200
Subject: [PATCH] pinctrl: sirf: add power management support for atlas7
In-Reply-To: <1437998245-13135-1-git-send-email-21cnbao@gmail.com>
References: <1437998245-13135-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdaLPwv8v0vh_4Jo0OooD+vwV_6XnPNuL8C6cem8btoJxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 1:57 PM, Barry Song <21cnbao@gmail.com> wrote:

> From: Wei Chen <Wei.Chen@csr.com>
>
> We had not implemented the pm interface of atlas7 pinctrl
> and gpio drivers. So when system resumes from sleep, all
> pin configuration and gpio status will be lost.
>
> Now, we implement these interfaces to support pm.
>
> At the same time, this patch also drops a lot of if-else
> by look-up table for getting and setting pull.
>
> Signed-off-by: Wei Chen <Wei.Chen@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Patch applied. Had to rebase it a bit so make sure to check the
result.

Yours,
Linus Walleij
