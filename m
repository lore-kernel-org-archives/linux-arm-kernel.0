From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 12:49:42 +0300
Subject: [PATCH v7 0/9] Generic PHY Framework
In-Reply-To: <51BEE203.6090103@samsung.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <51BEE203.6090103@samsung.com>
Message-ID: <20130618094942.GY5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 17, 2013 at 12:16:35PM +0200, Sylwester Nawrocki wrote:
> I have already used this API for our MIPI CSI-2/DSIM DPHYs driver,
> the RFC patch series can be found at [1].
> 
> Thanks,
> Sylwester
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg251666.html

one comment to that series:

let's make the phy names standardized, how about phy-exynos-video-mipi.c
or phy-mipi-csi-dsim.c ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/be6293fb/attachment.sig>
