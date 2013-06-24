From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 24 Jun 2013 21:27:20 +0200
Subject: [PATCH v7 0/9] Generic PHY Framework
In-Reply-To: <20130618094942.GY5461@arwen.pp.htv.fi>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <51BEE203.6090103@samsung.com> <20130618094942.GY5461@arwen.pp.htv.fi>
Message-ID: <51C89D98.1070806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/18/2013 11:49 AM, Felipe Balbi wrote:
> On Mon, Jun 17, 2013 at 12:16:35PM +0200, Sylwester Nawrocki wrote:
>> I have already used this API for our MIPI CSI-2/DSIM DPHYs driver,
>> the RFC patch series can be found at [1].
>>
>> Thanks,
>> Sylwester
>>
>> [1] http://www.spinics.net/lists/arm-kernel/msg251666.html
> 
> one comment to that series:
> 
> let's make the phy names standardized, how about phy-exynos-video-mipi.c
> or phy-mipi-csi-dsim.c ?

Yes, I have been thinking about that, wasn't sure exactly what pattern to
chose. I would make it phy-exynos-mipi-video.c, phy-exynos-dsim-csis.c feels
a bit odd. phy-mipi-csis-dsim.c might be to generic as MIPI CSIS stands for
MIPI CSI Slave and MIPI DSIM - MIPI DSI Master. And there might be (actually
are) IP blocks in an SoC that use the other MIPI Aliance standards.
For the HDMI PHY I guess just phy-exynos-hdmi.c could be used.

Thanks,
Sylwester
