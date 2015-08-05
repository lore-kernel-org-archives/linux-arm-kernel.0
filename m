From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Aug 2015 11:13:08 +0200
Subject: [PATCH] soc: mediatek: Fix SCPSYS compilation
In-Reply-To: <1438354993-21098-1-git-send-email-matthias.bgg@gmail.com>
References: <1438354993-21098-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <20150805091308.GN6390@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 05:03:13PM +0200, Matthias Brugger wrote:
> SCPSYS driver misses the module.h include which makes it fail
> when compiling with allmodconf.
> 
> This patch fixes this.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied, thanks.


-Olof
