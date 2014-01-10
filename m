From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 10 Jan 2014 14:51:20 +0800
Subject: [PATCH] ARM: dts: imx53-evk: Remove board support
In-Reply-To: <1389195114-6209-1-git-send-email-shc_work@mail.ru>
References: <1389195114-6209-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140110065116.GI21717@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 07:31:54PM +0400, Alexander Shiyan wrote:
> imx53-evk board is discontinued by Freescale. The replacement is
> imx53-qsb. Additionally this board is not supported by anyone and
> in their current state is non-functional, for example PMIC not have
> an IRQ line defined, so it is not works. This patch removes this DTS.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.  It will get into linux-next soon, and let's see if
there is anyone complaining.

Shawn
