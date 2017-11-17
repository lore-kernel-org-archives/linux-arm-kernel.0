From: horms@verge.net.au (Simon Horman)
Date: Fri, 17 Nov 2017 05:39:43 -0800
Subject: [PATCH v2 0/7] arm64: dts: renesas: r8a7796: IPMMU upstream
 integration
In-Reply-To: <20171110132612.1589-1-horms+renesas@verge.net.au>
References: <20171110132612.1589-1-horms+renesas@verge.net.au>
Message-ID: <20171117133943.svbzfoyen4on64ez@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 02:26:05PM +0100, Simon Horman wrote:
> This series adds DT nodes for IPMMU instances on r8a7796 together with
> connections to various r8a7796 on-chip devices such as Audio-DMAC, SYS-DMAC,
> Ethernet-AVB and a bunch of multimedia devices that make use of FCP.
> 
> With these patches applied a white list enabled IPMMU driver may be used
> to check silicon revision and then enable IPMMU in the known working cases.
> 
> The recommended test stack for this patchset is a merge of
> * The iommu/next branch of the vfio tree
> * renesas-devel-20171110-v4.14-rc8 tag of the renesas tree
> 
> With the following applied:
>  [PATCH v4 0/3] iommu/ipmmu-vmsa: r8a7796 support V4
> 
> The final patch in the series enable IPMMU support for all IPMMU
> instances on r8a7796 that are used by IPMMU devices listed above.
> 
> The DT binding for r8a7796 have been acked (as part of the r8a7796 series
> noted above) but have not yet been merged.
> 
> Changes since V1:
> * Drop mostly redundant comments from nodes
> * Add power domains
> 
> Based on work by Magnus Damm.
> 
> Based on renesas-devel-20171110-v4.14-rc8

I have applied this series.
