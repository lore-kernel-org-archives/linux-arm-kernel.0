From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 6 Jan 2011 15:44:28 +0900
Subject: [PATCH v3] video: imxfb: Fix the maximum value for yres
In-Reply-To: <1293193704-2855-1-git-send-email-fabio.estevam@freescale.com>
References: <1293193704-2855-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110106064428.GC15340@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 24, 2010 at 10:28:24AM -0200, Fabio Estevam wrote:
> MX27 and MX25 have 10 bits in the YMAX field of LCDC Size Register.
> 
> Fix the maximum value for yres.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
