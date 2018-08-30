From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2018 14:25:40 +0200
Subject: [PATCH v3 9/9] arm64: dts: renesas: r8a774a1: Add FCPF and FCPV
 instances
In-Reply-To: <20180827094805.luhtm4apitaxrsqg@verge.net.au>
References: <TY1PR01MB17700155CB2AB613EA824D6FC0360@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <1535106074-14032-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180827094805.luhtm4apitaxrsqg@verge.net.au>
Message-ID: <20180830122540.xcrmbumu4g4piy4z@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 11:48:09AM +0200, Simon Horman wrote:
> On Fri, Aug 24, 2018 at 11:21:14AM +0100, Fabrizio Castro wrote:
> > Add FCPF and FCPV instances to the r8a774a1 dtsi, similarly
> > to what was done for the r8a7796 with commit 41dbbf0c5b4e
> > ("arm64: dts: r8a7796: Add FCPF and FCPV instances"),
> > commit 69490bc9665d ("arm64: dts: renesas: r8a7796: Point
> > FDP1 via FCPF to IPMMU-VI0"), and commit cef942d0bd89 ("arm64:
> > dts: renesas: r8a7796: Point VSPI via FCPVI to IPMMU-VC0").
> > 
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> 
> Thanks,
> 
> This looks fine to me but I will wait to see if there are other reviews
> before applying.

Thanks again, applied for v4.20.
