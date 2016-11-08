From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Nov 2016 11:26:32 +0100
Subject: [PATCH 1/1] pinctrl: st: st_pinconf_dbg_show wrong format string
In-Reply-To: <20161105142515.4377-1-xypron.glpk@gmx.de>
References: <20161105142515.4377-1-xypron.glpk@gmx.de>
Message-ID: <CACRpkdb1OoFxYNwU9Zm=AcQuWNmogM0HsoiiWi=VNj-3HrCF1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 5, 2016 at 3:25 PM, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> function is defined as unsigned int.
> So we need %u to print it.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Patch applied with Patrice's ACK.

Yours,
Linus Walleij
