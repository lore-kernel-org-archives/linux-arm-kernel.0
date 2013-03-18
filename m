From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 18 Mar 2013 10:11:47 -0300
Subject: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
In-Reply-To: <20130318122650.GD12462@S2101-09.ap.freescale.net>
References: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
 <1363471581-10132-1-git-send-email-marex@denx.de>
 <20130318122650.GD12462@S2101-09.ap.freescale.net>
Message-ID: <51471293.5070105@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:

> Since it touches mach-mxs as well, let me send it through arm-soc tree
> as fix for 3.9.

Please CC stable as well, so that we can have X11 functional with 3.8.
