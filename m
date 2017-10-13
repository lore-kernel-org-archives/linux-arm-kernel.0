From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 13 Oct 2017 21:00:39 +0800
Subject: [PATCH v3 1/2] ARM: dts: imx: Fix incorrect display nodes notation
In-Reply-To: <1507213901-1349-1-git-send-email-marco.franchi@nxp.com>
References: <1507213901-1349-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <20171013130037.GM8833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 11:31:40AM -0300, Marco Franchi wrote:
> The following build warnings are seen with W=1:
> 
> Warning (unit_address_vs_reg): Node /display at di0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /display at di1 has a unit name, but no reg property
> 
> Fix all these warnings by changing 'display at diX' to 'dispX'.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied both, thanks.
