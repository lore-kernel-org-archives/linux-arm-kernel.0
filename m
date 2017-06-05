From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Jun 2017 23:22:44 +0800
Subject: [PATCH v2] arm64: dts: ls1012a: Add coreclk
In-Reply-To: <1496633302-2795-1-git-send-email-andy.tang@nxp.com>
References: <1496633302-2795-1-git-send-email-andy.tang@nxp.com>
Message-ID: <20170605152243.GM4094@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 11:28:22AM +0800, Yuantian Tang wrote:
> From: Scott Wood <oss@buserror.net>
> 
> ls1012a has separate input root clocks for core PLLs versus the platform
> PLL, with the latter described as sysclk in the hw docs.
> Accordingly, update the clock-frequency in sysclk to 125M as platform
> input clock.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>

Applied, thanks.
