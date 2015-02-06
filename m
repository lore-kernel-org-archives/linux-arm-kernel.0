From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Feb 2015 16:15:42 +0100
Subject: [PATCH v4 0/7] clk: Add common clock support for Mediatek MT8135
 and MT8173.
In-Reply-To: <CABuKBeJBp115aD_xb7_2471h=iyr5Wc33m2EX715MxNc=_1p2A@mail.gmail.com>
References: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
 <CABuKBeJSH3WzG3QC=9OoPzXE6fd9W2U67V4c19NzWcPxWR7VDg@mail.gmail.com>
 <20150206103033.GS18908@pengutronix.de>
 <CABuKBeJBp115aD_xb7_2471h=iyr5Wc33m2EX715MxNc=_1p2A@mail.gmail.com>
Message-ID: <20150206151542.GO12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 03:20:35PM +0100, Matthias Brugger wrote:
> > I don't really understand the "as part of the clk driver part". I now
> > have replaced the devm_regmap_init_mmio with syscon_node_to_regmap
> > in the pericfg / infracfg drivers. Is that all that you want or do you
> > want me to move the source code to drivers/clk/mediatek?
> 
> Yes, I propose to move the source code to drivers/clk/mediatek.
> Please have a look on other clock drivers which implement the reset
> controller, e.g. rockchip.

Ok, I'm halfway through implementing this, but let's have weekend first.

Henry, If you're fine with this I'll change your clock series according
to Matthias suggestions.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
