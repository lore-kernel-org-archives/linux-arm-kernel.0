From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 May 2012 14:29:28 +0200
Subject: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
In-Reply-To: <20120511053218.GT17875@S2101-09.ap.freescale.net>
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
 <20120511053218.GT17875@S2101-09.ap.freescale.net>
Message-ID: <CACRpkdY3Ga0soie+tsALxA1yhzXbyVOj_HbLLWOjRPz6cMLqtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 7:32 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> pinctrl-mergebase-20120418 is not enough for me. ?I need mxs and dummy
> states support. ?So if your devel branch will never be rebased, we can
> simply ask Arnd and Olof to get that as the dependent branch?

Hm, yes the devel branch is getting real stable now, so I will only add things
on top.

Basically the for-next branch is supposed to be even more stable,
but right now it's a copy of devel.

ARM SoC guys: how do you want the pinctrl deps? I can make
a tag today if that is preferred.

Also: short-cut to another subject: how have you other guys managed
this? By e.g.:

git fetch <pinctrl tree>

git checkout -b my-pinwork v3.4-rc4
git merge pinctrl-tag
(develop develop)

Or:

git checkout -b my-pinwork pinctrl-tag

?

I was a bit uncertain on how to do this for the pending Ux500
stuff so better ask. I merged it for now but maybe it's better if
I just base the whole pullrequest on top of a stable pinctrl
branch?

Yours,
Linus Walleij
