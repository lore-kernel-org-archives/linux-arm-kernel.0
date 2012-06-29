From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Jun 2012 20:53:49 +0800
Subject: [PATCH 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <20120629124158.GA32473@shlinux2.ap.freescale.net>
References: <20120629020650.GB28932@S2101-09.ap.freescale.net>
 <20120629063329.GE5844@shlinux2.ap.freescale.net>
 <20461.30070.771087.830745@ipc1.ka-ro>
 <20120629093437.GK5844@shlinux2.ap.freescale.net>
 <20461.30991.63507.369439@ipc1.ka-ro>
 <20120629095433.GO5844@shlinux2.ap.freescale.net>
 <20120629111334.GB29197@S2101-09.ap.freescale.net>
 <20120629121437.GQ5844@shlinux2.ap.freescale.net>
 <20120629124154.GG29197@S2101-09.ap.freescale.net>
 <20120629124158.GA32473@shlinux2.ap.freescale.net>
Message-ID: <20120629125346.GI29197@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 08:41:59PM +0800, Dong Aisheng wrote:
> I know this.
> You may missed my point.
> I mean extra clocks introduced for imx6q which is not exist on imx28.
> For your proposal, the gpmi driver will acquire all clocks including
> imx6q's.
> So when get imx6q's gpmi clock like "gpmi-bch" like clk_get(dev, "gpmi-bch"),
> it may fail for imx28.
> 
What I was saying is it will not fail.

-- 
Regards,
Shawn
