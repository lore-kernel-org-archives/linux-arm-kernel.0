From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 27 Dec 2017 10:32:07 +0800
Subject: [PATCH V2] ARM: imx: suspend/resume: use outer_disable/resume
In-Reply-To: <1514339867-28946-1-git-send-email-peng.fan@nxp.com>
References: <1514339867-28946-1-git-send-email-peng.fan@nxp.com>
Message-ID: <20171227023207.GX23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 09:57:47AM +0800, Peng Fan wrote:
> Use outer_disable/resume for suspend/resume.
> With the two APIs used, code could be simplified and easy to extend
> to introduce l2c_write_sec for i.MX platforms when moving Linux Kernel
> runs in non-secure world.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>

@Aisheng, can you please give it a test?

Shawn
