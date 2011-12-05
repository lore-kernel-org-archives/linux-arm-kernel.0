From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Dec 2011 18:03:10 +0100
Subject: [RFC PATCH 2/3] pinctrl: imx: add pinmux-imx53 support
In-Reply-To: <CAA+hA=RM77XORR-cUrFSW_rfn=KG9B1gr-Ny0jcDsU1_NiTT7A@mail.gmail.com>
References: <1322999384-7886-1-git-send-email-b29396@freescale.com>
 <1322999384-7886-2-git-send-email-b29396@freescale.com>
 <20111204161123.GS27267@pengutronix.de>
 <CAA+hA=RM77XORR-cUrFSW_rfn=KG9B1gr-Ny0jcDsU1_NiTT7A@mail.gmail.com>
Message-ID: <CACRpkdZiyrkezn16ihmB_jQvM2QmG375_8jYykkQNAGCHMZZEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 5, 2011 at 3:43 AM, Dong Aisheng <dongas86@gmail.com> wrote:

> My current plan is to define all (might be frequently) used functoin
> and groups for the exist upstreamed board like 53 Loco and etc, is
> that ok?

Yes, but do it in respective board file, so if we say, one day
stops to support a certain board we can just delete that board
file and be done with it.

Plus this gives us a nice separation as we move toward
device trees. (I think.)

Yours,
Linus Walleij
