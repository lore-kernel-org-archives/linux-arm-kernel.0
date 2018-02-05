From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 5 Feb 2018 09:24:38 +0200
Subject: [PATCH v2 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180201183126.32384-3-l.stach@pengutronix.de>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-3-l.stach@pengutronix.de>
Message-ID: <20180205072438.nxvhlqk54d7firbz@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Thu, Feb 01, 2018 at 07:31:25PM +0100, Lucas Stach wrote:
> This is the evaluation kit board for the i.MX8M. The current level of
> support yields a working console and is able to boot userspace from
> SD card or Network.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com> (v1)
> Tested-by: Tested-by: Baruch Siach <baruch@tkos.co.il> (v1)

I only tested once.

Tested v2 as well, on top of clk v2 and the pinctrl v2 patches.

Tested-by: Baruch Siach <baruch@tkos.co.il>

Would have been nice to have all these series in a single branch somewhere.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
