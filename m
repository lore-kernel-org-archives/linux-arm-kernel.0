From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 24 Jun 2013 21:42:00 +0200
Subject: [PATCH 0/4] IPU DMFC bandwidth allocation fix and cleanups
In-Reply-To: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
References: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130624194200.GV32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 10:57:17AM +0200, Philipp Zabel wrote:
> Hi,
> 
> the following patches remove some unused variables, replace some
> hard-coded channel numbers with existing descriptive defines, fix
> the DMFC bandwidth (or rather: FIFO space) allocation, and update
> ipu_page_flip() to immediately set crtc->fb.    


Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
