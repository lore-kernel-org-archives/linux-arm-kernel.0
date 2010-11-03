From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 3 Nov 2010 08:25:29 -0700 (PDT)
Subject: [patch 1/1] imx: fix iomux v3
In-Reply-To: <20101103145508.186441704@rtp-net.org>
Message-ID: <321894.13477.qm@web51008.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

--- On Wed, 11/3/10, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:

> From: Arnaud Patard <arnaud.patard@rtp-net.org>
> Subject: [patch 1/1] imx: fix iomux v3
> To: s.hauer at pengutronix.de
> Cc: linux-arm-kernel at lists.infradead.org, LW at KARO-electronics.de
> Date: Wednesday, November 3, 2010, 12:54 PM
> Commit "ARM: i.MX IOMUX-V3 replace
> struct pad_desc with bitmapped cookie"
> (b705cb4d42e95a4a43a8945571c8613e71526c3d) introduced a
> typo which was
> preventing my efikamx to boot. This patch is fixing that.

Thanks. When I tried 2.6.37-rc1 today I was not able to boot Linux on Babbage. Your patch fixed the problem.
 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Regards,

Fabio Estevam


      
