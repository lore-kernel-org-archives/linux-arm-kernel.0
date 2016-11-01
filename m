From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 1 Nov 2016 15:59:48 -0400
Subject: [PATCH v3 2/6] net: phy: broadcom: Add BCM54810 PHY entry
In-Reply-To: <20161101184639.GI10785@lunn.ch>
References: <1478022694-25308-1-git-send-email-jon.mason@broadcom.com>
 <1478022694-25308-3-git-send-email-jon.mason@broadcom.com>
 <20161101184639.GI10785@lunn.ch>
Message-ID: <20161101195946.GA26962@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 07:46:39PM +0100, Andrew Lunn wrote:
> Hi Jon
> 
> > @@ -56,6 +57,8 @@
> >  #define PHY_BRCM_EXT_IBND_TX_ENABLE	0x00002000
> >  #define PHY_BRCM_CLEAR_RGMII_MODE	0x00004000
> >  #define PHY_BRCM_DIS_TXCRXC_NOENRGY	0x00008000
> > +#define PHY_BRCM_EXP_LANE_SWAP		0x00010000
> > +
> 
> You define this, but don't use it...

Good catch.  Cruft from the last patch.  I'll sendout a quick v4 to
address this and the missing Documentation patch.

> 
>     Andrew
