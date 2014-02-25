From: tj@kernel.org (Tejun Heo)
Date: Tue, 25 Feb 2014 08:45:17 -0500
Subject: [PATCH RESEND v10 1/4] PHY: Add function set_speed to generic
 PHY framework
In-Reply-To: <530C8711.4000600@ti.com>
References: <1393308882-3964-1-git-send-email-lho@apm.com>
 <1393308882-3964-2-git-send-email-lho@apm.com>
 <530C8711.4000600@ti.com>
Message-ID: <20140225134517.GA26189@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 05:35:37PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 25 February 2014 11:44 AM, Loc Ho wrote:
> > This patch adds function set_speed to the generic PHY framework operation
> > structure. This function can be called to instruct the PHY underlying layer
> > at specified lane to configure for specified speed in hertz.
> > 
> > Signed-off-by: Loc Ho <lho@apm.com>
> > ---
> >  drivers/phy/phy-core.c  |   21 +++++++++++++++++++++
> >  include/linux/phy/phy.h |    8 ++++++++
> >  2 files changed, 29 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > index 645c867..44f2f63 100644
> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> > @@ -257,6 +257,27 @@ int phy_power_off(struct phy *phy)
> >  }
> >  EXPORT_SYMBOL_GPL(phy_power_off);
> >  
> 
> missing function comment :-s

Can you please let me know when this series goes in?  I'll pull in the
phy tree into libata and then apply the ata patches on top.

Thanks.

-- 
tejun
