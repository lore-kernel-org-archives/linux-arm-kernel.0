From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 24 Aug 2018 13:44:04 +0300
Subject: [PATCH v2 9/9] arm64: dts: renesas: r8a774a1: Add FCPF and FCPV
 instances
In-Reply-To: <1535103029-10576-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <c27a266e-3eaa-a879-85ab-0e0aeb5f8b31@cogentembedded.com>
 <1535103029-10576-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <c91704ce-4eb1-4017-973d-a6cce88adfd1@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2018 12:30 PM, Fabrizio Castro wrote:

> Add FCPF and FCPV instances to the r8a774a1 dtsi, similarly
> to what was done for the r8a7796 with commits 41dbbf0c5 ("arm64: dts:
                                                ^^^^^^^^^
   Still 8 digits...

> r8a7796: Add FCPF and FCPV instances"), 69490bc9665d ("arm64: dts:
> renesas: r8a7796: Point FDP1 via FCPF to IPMMU-VI0"), and cef942d0bd89
> ("arm64: dts: renesas: r8a7796: Point VSPI via FCPVI to IPMMU-VC0").
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
[...]

MBR, Sergei
