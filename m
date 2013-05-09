From: jim_baxter@mentor.com (Jim Baxter)
Date: Thu, 9 May 2013 10:35:15 +0100
Subject: [PATCH] net: fec: enable hardware checksum only on imx6q-fec
In-Reply-To: <1368083302-12516-1-git-send-email-shawn.guo@linaro.org>
References: <1368083302-12516-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <518B6DD3.1040201@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/13 08:08, Shawn Guo wrote:
> Commit 4c09eed (net: fec: Enable imx6 enet checksum acceleration.)
> enables hardware checksum acceleration unconditionally for all fec
> variants.  This is inappropriate, because some variants like imx5 have
> no such support on hardware.  Consequently, fec is broken on these
> platforms.  Fix it by enabling hardware checksum only on imx6q-fec type
> of controllers.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Jim Baxter <jim_baxter@mentor.com>
