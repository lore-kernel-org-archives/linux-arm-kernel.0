From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2018 14:19:52 +0200
Subject: [PATCH 2/9] arm64: dts: renesas: r8a774a1: Add I2C and IIC-DVFS
 support
In-Reply-To: <20180827085135.bjzbiws7tdtig5kd@verge.net.au>
References: <1535031788-19907-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535031788-19907-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180827085135.bjzbiws7tdtig5kd@verge.net.au>
Message-ID: <20180830121952.sr3hjtx6focfidrf@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 10:51:35AM +0200, Simon Horman wrote:
> On Thu, Aug 23, 2018 at 02:43:01PM +0100, Fabrizio Castro wrote:
> > From: Biju Das <biju.das@bp.renesas.com>
> > 
> > Add the I2C[0-6] and IIC Bus Interface for DVFS (IIC for DVFS)
> > devices nodes to the r8a774a1 device tree.
> > 
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> Thanks,
> 
> This looks fine to me but I will wait to see if there are other reviews
> before applying.

Thanks again, applied for v4.20.
