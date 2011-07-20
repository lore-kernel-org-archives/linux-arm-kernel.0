From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Jul 2011 14:16:31 +0300
Subject: [PATCH 1/7] consolidate definitions and structures to share
	among platforms
In-Reply-To: <97D3A72708D04647A5AC84A04996E5B5161640@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-2-git-send-email-tony.lin@freescale.com>
	<20110720105933.GJ764@legolas.emea.dhcp.ti.com>
	<97D3A72708D04647A5AC84A04996E5B5161640@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <20110720111630.GO764@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 20, 2011 at 11:03:56AM +0000, Lin Tony-B19295 wrote:
> > I believe this patch will cause build breakage since ehci-mxc.c doesn't
> > include <linux/fsl_devices.h> ??
> Ehci-mxc.c does include <linux/fsl_devices.h>, please check patch 5/7. Thanks

that's too late. You will always have the broken bisection point.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/3b981ab7/attachment.sig>
