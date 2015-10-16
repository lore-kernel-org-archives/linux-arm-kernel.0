From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Oct 2015 20:13:13 +0800
Subject: [PATCH] arm: dts: ls1021a: Add quirk for Erratum A009116
In-Reply-To: <1444800852-19523-1-git-send-email-rajesh.bhagat@freescale.com>
References: <1444800852-19523-1-git-send-email-rajesh.bhagat@freescale.com>
Message-ID: <20151016121313.GF584@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 11:04:12AM +0530, Rajesh Bhagat wrote:
> Add "snps,quirk-frame-length-adjustment" property to
> USB3 node for erratum A009116. This property provides
> value of GFLADJ_30MHZ for post silicon frame length
> adjustment.
> 
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@freescale.com>

Changed the patch prefix to use uppercase "ARM: " and applied the patch.

Shawn
