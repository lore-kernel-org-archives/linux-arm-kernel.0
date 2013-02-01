From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 01 Feb 2013 09:36:58 -0800
Subject: [PATCH 5/5] s5p-fimc: Redefine platform data structure for fimc-is
In-Reply-To: <510BA174.1010602@samsung.com>
References: <1359566606-31394-1-git-send-email-s.nawrocki@samsung.com>
 <1359566606-31394-6-git-send-email-s.nawrocki@samsung.com>
 <510BA174.1010602@samsung.com>
Message-ID: <0c4d01ce00a2$be31cdc0$3a956940$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> On 01/30/2013 06:23 PM, Sylwester Nawrocki wrote:
> > Newer Exynos4 SoC are equipped with a local camera ISP that
> > controls external raw image sensor directly. Such sensors
> > can be connected through FIMC-LITEn (and MIPI-CSISn) IPs to
> > the ISP, which then feeds image data to the FIMCn IP. Thus
> > there can be two busses associated with an image source
> > (sensor). Rename struct s5p_fimc_isp_info describing external
> > image sensor (video decoder) to struct fimc_source_info to
> > avoid confusion. bus_type is split into fimc_bus_type and
> > sensor_bus_type. The bus type enumeration is extended to
> > include both FIMC Writeback input types.
> >
> > The bus_type enumeration and the data structure name in the
> > board files are modified according to the above changes.
> >
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: linux-samsung-soc at vger.kernel.org
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Kukjin, can I please have your ack on this patch so it can be
> merged through the media tree ?
> 
Sure, why not? Please go ahead with my ack:

Acked-by: Kukjin Kim <kgene.kim@samsung.com>
