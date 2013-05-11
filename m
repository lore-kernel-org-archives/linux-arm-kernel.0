From: davem@davemloft.net (David Miller)
Date: Sat, 11 May 2013 16:12:57 -0700 (PDT)
Subject: [PATCH] net: fec: enable hardware checksum only on imx6q-fec
In-Reply-To: <1368083302-12516-1-git-send-email-shawn.guo@linaro.org>
References: <1368083302-12516-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130511.161257.1222305719812815291.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 9 May 2013 15:08:22 +0800

> Commit 4c09eed (net: fec: Enable imx6 enet checksum acceleration.)
> enables hardware checksum acceleration unconditionally for all fec
> variants.  This is inappropriate, because some variants like imx5 have
> no such support on hardware.  Consequently, fec is broken on these
> platforms.  Fix it by enabling hardware checksum only on imx6q-fec type
> of controllers.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied.
