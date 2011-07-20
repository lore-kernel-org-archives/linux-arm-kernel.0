From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Jul 2011 14:27:43 +0300
Subject: [PATCH 5/7] ehci mxc: make it more flexible to be used for mx28
In-Reply-To: <97D3A72708D04647A5AC84A04996E5B51616D5@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-6-git-send-email-tony.lin@freescale.com>
	<20110720111442.GN764@legolas.emea.dhcp.ti.com>
	<97D3A72708D04647A5AC84A04996E5B51616AD@039-SN1MPN1-006.039d.mgd.msft.net>
	<20110720112305.GP764@legolas.emea.dhcp.ti.com>
	<97D3A72708D04647A5AC84A04996E5B51616D5@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <20110720112742.GQ764@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 20, 2011 at 11:25:07AM +0000, Lin Tony-B19295 wrote:
> > > But I had to following the existing framework. I didn't add any new
> > special to the driver.
> > > Just try some ways to workaround these ugly points.
> > 
> > but in that case, since you're already there... why not cleaning those
> > things up before making your changes ?
> > 
> Ok, I'll clean up these things. Thanks, balbi.

no problem ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/d31e72d9/attachment-0001.sig>
