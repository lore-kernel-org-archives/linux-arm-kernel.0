From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 10 Aug 2018 08:03:34 +0200
Subject: [PATCH v3 0/4] Add i.MX8MQ clock driver
In-Reply-To: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
References: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <20180810060334.ookq3dm3vylp623o@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abel,

On Thu, Aug 09, 2018 at 05:45:37PM +0300, Abel Vesa wrote:
> This is basically just a resend of the following patchset:
> 
> https://www.spinics.net/lists/linux-clk/msg23141.html
> 
> I've just updated the patchset and implemented Shawn's
> and Aisheng's comments.
> 
> I hope I haven't missed any of their comments.

I think what I said to v2 back in march still stays valid:

> A general thought: The i.MX8M finally has a consistent clock tree. We
> have for example 70 Peripheral clock slices consisting of a mux, a gate
> and two dividers, all 70 looking the same.
> For these it might make sense to create a more complex clock type
> providing mux, gate and set rate functionality in one clock. This would
> drastically reduce the number of clocks we have to handle.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
