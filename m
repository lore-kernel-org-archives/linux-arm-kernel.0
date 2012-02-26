From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 26 Feb 2012 09:33:27 +0000
Subject: [PATCH 3/6] ux500: select MFD_SUPPORT when needed
In-Reply-To: <1330199707-5179-3-git-send-email-mathieu.poirier@linaro.org>
References: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
 <1330199707-5179-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201202260933.27809.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 25 February 2012, mathieu.poirier at linaro.org wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When the MFD_DBx500_PRCMU driver is selected, we
> also need to select MFD_SUPPORT to guarantee a
> successful build.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

This one has actually become obsolete now, the MFD_SUPPORT
option was recently removed.

	Arnd
