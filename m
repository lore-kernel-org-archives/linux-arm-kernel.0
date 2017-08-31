From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Aug 2017 09:11:11 +0200
Subject: [PATCH] pinctrl: mediatek: update PCIe mux data for MT7623
In-Reply-To: <ddbc91742005abfc9083876fb976ecc511be98fd.1503026874.git.ryder.lee@mediatek.com>
References: <ddbc91742005abfc9083876fb976ecc511be98fd.1503026874.git.ryder.lee@mediatek.com>
Message-ID: <CACRpkdY6kiPRC9tD3joNwdcj63La06eKnFe_D7s4bpP4a=CO5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 5:48 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:

> MT2701 shares the same driver with MT7623, but there is a slight difference
> between their pin functions (e.g., PCIe), so we update the different parts
> in pinmux table.
>
> Doing so, SoC could choose the correct mux setting via their own pinfun.h.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> CC: Biao Huang <biao.huang@mediatek.com>

No reaction in 13 days from any maintainer.
Patch applied.

Yours,
Linus Walleij
