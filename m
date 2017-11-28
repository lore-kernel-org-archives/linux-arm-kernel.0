From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 Nov 2017 09:32:32 +0100
Subject: [PATCH v2 0/2] dts: renesas: r8a77995: IPMMU upstream integration
In-Reply-To: <20171110132605.1537-1-horms+renesas@verge.net.au>
References: <20171110132605.1537-1-horms+renesas@verge.net.au>
Message-ID: <20171128083232.qqqlrt6l2ds44xoo@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 02:26:03PM +0100, Simon Horman wrote:
> This series adds DT nodes for IPMMU instances on r8a77995 together with
> connections to the r8a77995 on-chip device Ethernet-AVB.
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
>  [PATCH 0/2] iommu/ipmmu-vmsa: r8a779(70|95) support
> 
> A patch to enable IPMMU devices is not included in this series
> as Ethernet-AVB, the only device to which IPMMU is hooked up to,
> is disabled.
> 
> The DT binding for r8a77995 has been submitted (as part of the
> r8a779(70|95) series noted above) in conjunction with this patchset.
> 
> This is based on work by Magnus Damm.
> 
> Based on renesas-devel-20171110-v4.14-rc8
> 
> Changes since V1:
> * Drop mostly redundant comments from nodes
> 
> Simon Horman (2):
>   arm64: dts: renesas: r8a77995: Add IPMMU device nodes
>   arm64: dts: renesas: r8a77995: Connect Ethernet-AVB to IPMMU-RT

Applied for v4.16.
