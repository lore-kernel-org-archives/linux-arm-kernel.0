From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 4 Jul 2016 11:51:02 +0300
Subject: [PATCH] phy: fix error handling
In-Reply-To: <577A15D2.5010103@ti.com>
References: <1467525332-12963-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <00d5243a-0359-1dc7-e9aa-1ad8a9074821@wanadoo.fr>
 <577A15D2.5010103@ti.com>
Message-ID: <20160704085102.GF32301@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 01:22:50PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 04 July 2016 02:38 AM, Christophe JAILLET wrote:
> > I will resubmit in the coming days.
> > 
> >    return PTR_ERR(phy->clk);
> > should also be updated.
> 
> while at that, also fix your $subject to something like
> "phy: sun9i-usb: fix error handling"
> 

Yes.  Also the first patch should have used that same prefix.
9c3b44302636 ('phy: Add driver to support individual USB PHYs on sun9i')

We have this problem quite often, but other subsystems have fixed it
because they start using the correct prefix when the driver is added.
The second patch for this driver had the same issue:
9c3b44302636 ('phy: Add driver to support individual USB PHYs on sun9i')

regards,
dan carpenter
