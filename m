From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Oct 2015 16:18:14 +0200
Subject: [PATCH v6 7/7] arm64: dts: berlin4ct: add default pinmux for uart0
In-Reply-To: <1444981032-4401-8-git-send-email-jszhang@marvell.com>
References: <1444981032-4401-1-git-send-email-jszhang@marvell.com>
 <1444981032-4401-8-git-send-email-jszhang@marvell.com>
Message-ID: <CACRpkdYUmkOB_9Rm_YXzqQDL8H7wXmptwwHeGbssQO_RK_G17w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 9:37 AM, Jisheng Zhang <jszhang@marvell.com> wrote:

> Add urt0 txd and rxd muxing setup in the dtsi because uart0 always uses
> them to work, no other possibilities.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Funnel this through ARM SoC.

Yours,
Linus Walleij
