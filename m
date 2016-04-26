From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Apr 2016 11:22:40 +0800
Subject: [PATCH] ARM: dts: imx6q-ba16: use wdog external reset
In-Reply-To: <1461083401-12662-1-git-send-email-akshay.bhat@timesys.com>
References: <1461083401-12662-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <20160426032239.GF8870@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 12:30:01PM -0400, Akshay Bhat wrote:
> The BA16 module has a PMIC that uses the WDOG_B output from iMX6 to
> reset the system on a watchdog timeout. Configure the watchdog to assert
> the external reset signal (WDOG_B) using fsl,ext-reset-output property.
> 
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>

Applied, thanks.
