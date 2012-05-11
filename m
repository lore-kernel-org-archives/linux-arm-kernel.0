From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 13:32:20 +0800
Subject: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
In-Reply-To: <CACRpkdah3956QLZZ1wTw1PcZ90wWX=Ta9j45jjzWsBtT=nm8-g@mail.gmail.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
 <20120510084403.GA3908@opensource.wolfsonmicro.com>
 <20120510090459.GH2982@b20223-02.ap.freescale.net>
 <20120510092733.GH3908@opensource.wolfsonmicro.com>
 <20120510102309.GK2982@b20223-02.ap.freescale.net>
 <CACRpkdah3956QLZZ1wTw1PcZ90wWX=Ta9j45jjzWsBtT=nm8-g@mail.gmail.com>
Message-ID: <20120511053218.GT17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 02:26:31PM +0200, Linus Walleij wrote:
> The tag pinctrl-mergebase-20120418
> contains the devm and other changes, Stephen is already using
> that for Tegra stuff and it's solid as a rock. Newer patches are
> put on top of this and since pinctrl has no deps in any directions
> it will be requested for pull as soon as the merge window opens.
> 
Hi Linus,

pinctrl-mergebase-20120418 is not enough for me.  I need mxs and dummy
states support.  So if your devel branch will never be rebased, we can
simply ask Arnd and Olof to get that as the dependent branch?

-- 
Regards,
Shawn
