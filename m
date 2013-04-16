From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Apr 2013 21:18:35 -0300
Subject: [PATCH v2 3/4] ARM: dts: mx53qsb: Add support for parallel display
In-Reply-To: <20130413170943.GX1906@pengutronix.de>
References: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
 <1365516452-1287-3-git-send-email-rogerio.pimentel@freescale.com>
 <1365520643.4023.52.camel@pizza.hi.pengutronix.de>
 <CAOkaPuV2xNR=Vxsa6tPdnPS34Q5ffV9-f8DefhcJfvVvXWOADQ@mail.gmail.com>
 <20130413170943.GX1906@pengutronix.de>
Message-ID: <CAOMZO5DwoP4WXEVfKkqbfrJ60s0GxqkLOa_h1TQNJXY61_NTbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha/Phillip,

On Sat, Apr 13, 2013 at 2:09 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Having the parallel display support is fine. Philipp just suggested to
> add status = "disabled" for both the parallel display and the lvds
> encoder so that for example the bootloader can decide which one to enable
> during runtime. Otherwise we have two display options on the same pins and
> the first one wins.

Ok, understood.

It is not clear how we can tell the bootloader that we want the CLAA
WVGA panel or the HDMI daughter card, for example?

What would be the kernel command line in each case?

Thanks,

Fabio Estevam
