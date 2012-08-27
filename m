From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Aug 2012 11:13:11 -0700
Subject: [PATCH V2 3/6] ASoC/ARM: Davinci: McASP: split asp header into
 platform and audio specific
In-Reply-To: <1346074004-22172-4-git-send-email-gururaja.hebbar@ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
 <1346074004-22172-4-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120827181311.GV4339@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 06:56:41PM +0530, Hebbar, Gururaja wrote:
> Davinci McASP header & driver are shared by few OMAP platforms (like
> TI81xx, AM335x). Splitting asp header into Davinci platform specific
> header and Audio specific header helps to share them across platforms.

Applied, thanks.
