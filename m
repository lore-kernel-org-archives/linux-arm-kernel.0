From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Mar 2013 23:14:43 +0800
Subject: [PATCH V2 1/3] ARM: imx: enable anatop suspend/resume
In-Reply-To: <1363822784-12700-1-git-send-email-b20788@freescale.com>
References: <1363822784-12700-1-git-send-email-b20788@freescale.com>
Message-ID: <20130320151440.GA6281@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 07:39:42PM -0400, Anson Huang wrote:
> Anatop module have sereval configurations for user
> to reduce the power consumption in suspend, provide
> suspend/resume interface for further use and enable
> fet_odrive to reduce CORE LDO leakage during suspend.
> 
> As we have a common anatop file, remove all the operations
> of anatop module in other files, use anatop interfaces to
> do that.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
