From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 9 May 2012 08:25:37 +0800
Subject: [PATCH] ARM: imx6q: register phy fixup only when CONFIG_PHYLIB
 is enabled
In-Reply-To: <1336484785-8881-1-git-send-email-shawn.guo@linaro.org>
References: <1336478520.23308.36.camel@sauron.fi.intel.com>
 <1336484785-8881-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120509002536.GF2982@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I remembered you picked my patch that move sabrelite board specific
code to a dedicate function? why not base on that?

Thanks
Richard 
