From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 27 Jul 2012 13:52:58 -0300
Subject: [PATCH 1/2] hw_random: mxc-rnga: Adapt clocks to new i.mx clock
 framework
In-Reply-To: <20120709074158.GS30009@pengutronix.de>
References: <1341606020-26449-1-git-send-email-fabio.estevam@freescale.com>
 <20120709074158.GS30009@pengutronix.de>
Message-ID: <CAOMZO5D+W_VwW=oQaSanogU=9yT=86hV1UN+M3-8JEo0_S9fDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2012 at 4:41 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Uhh, that's a driver bug that should be fixed. Although right now there
> is no reference counting for clocks, the driver should keep the clk
> internally instead of simply calling clk_get whenever it needs access to
> a clk.

Yes, I just sent a fix for this.
