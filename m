From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Mar 2017 15:06:14 +0100
Subject: [PATCH 1/2] arm64: dts: added ecc register address to sata node
 on ls1043a
In-Reply-To: <1486621755-6567-1-git-send-email-yuantian.tang@nxp.com>
References: <1486621755-6567-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <20170308140613.GD19934@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 02:29:14PM +0800, yuantian.tang at nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> For ls1043 sata, ecc should be disabled due to a erratum.
> Provide the ecc register address for driver to use.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>

Applied both, thanks.
