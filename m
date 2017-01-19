From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 Jan 2017 10:03:14 -0200
Subject: [PATCH 4/4] ARM: dts: imx7: Add "LPSR" to LPSR iomux pin names
In-Reply-To: <20170119090924.19636-5-s.hauer@pengutronix.de>
References: <20170119090924.19636-1-s.hauer@pengutronix.de>
 <20170119090924.19636-5-s.hauer@pengutronix.de>
Message-ID: <CAOMZO5AkXOeXFWni7kLKn7tWEqMJR_JyAFMekeRH2hR5NU0j6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 7:09 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The i.MX7 has two iomux controllers. the iomuxc and the iomuxc_lpsr.
> In a board dts we have to make sure that both controllers are supplied
> with the correct pins. It's way too easy to do this wrong since only
> a look into the reference manual can reveal which pins belong to which
> controller. To make this clearer add "LPSR" to the pin names which
> belong to the LPSR controller.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I like this idea!

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
