From: horms@verge.net.au (Simon Horman)
Date: Thu, 18 Oct 2018 15:10:31 +0200
Subject: [PATCH 5/5] ARM: shmobile: defconfig: Enable SII902X
In-Reply-To: <20180924090850.krd2cjzf6cyfdfh6@verge.net.au>
References: <1537553311-8831-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1537553311-8831-6-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180924090850.krd2cjzf6cyfdfh6@verge.net.au>
Message-ID: <20181018131031.lfjfy46zxkbdjvfa@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 11:08:51AM +0200, Simon Horman wrote:
> On Fri, Sep 21, 2018 at 07:08:31PM +0100, Fabrizio Castro wrote:
> > The iwg23s board comes with the SiI9022ACNU HDMI transmitter,
> > this patch makes sure the corresponding driver gets built.
> > 
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> > 
> > Hello Simon,
> > 
> > a patch for the multi_v7_defconfig will be sent at a later stage.
> 
> Thanks Fabrizio,
> 
> This looks fine to me but I will wait to see if there are other reviews
> before applying.

Sorry for letting this slip.

I have applied it for v4.21.
