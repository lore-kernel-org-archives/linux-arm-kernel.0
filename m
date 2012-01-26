From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Jan 2012 20:33:45 +0800
Subject: [PATCH] ARM: mx28: Remove duplicate OCOTP error message
In-Reply-To: <1327332593-27534-1-git-send-email-fabio.estevam@freescale.com>
References: <1327332593-27534-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120126123343.GD3523@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 01:29:53PM -0200, Fabio Estevam wrote:
> The mxs_get_ocotp() function already prints an error message in the case of 
> a timeout, so no need to print them again in the board files.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

-- 
Regards,
Shawn
