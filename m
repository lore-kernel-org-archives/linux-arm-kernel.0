From: fugang.duan@freescale.com (Duan Andy)
Date: Fri, 21 Aug 2015 23:49:41 +0000
Subject: [PATCH v1 0/6] Add fec1 and fec2 support for i.MX7d sdb board
In-Reply-To: <20150820.140531.1320709021949935376.davem@davemloft.net>
References: <1439962444-27486-1-git-send-email-b38611@freescale.com>
 <20150820.140531.1320709021949935376.davem@davemloft.net>
Message-ID: <BN3PR0301MB1219615039D291CCCD751B2EF5650@BN3PR0301MB1219.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Miller <davem@davemloft.net> Sent: Friday, August 21, 2015 5:06 AM
> To: Duan Fugang-B38611
> Cc: shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org;
> netdev at vger.kernel.org
> Subject: Re: [PATCH v1 0/6] Add fec1 and fec2 support for i.MX7d sdb
> board
> 
> From: Fugang Duan <b38611@freescale.com>
> Date: Wed, 19 Aug 2015 13:33:58 +0800
> 
> > The patch series is to add fec support for i.MX7d sdb board. Since
> > i.MX7d fec ip is the same as i.MX6SX, so there have no change for
> driver itself.
> >
> > Patch#1: add bcm54220 PHY ID entry into brcmphy.h file.
> 
> This is completely, and utterly, pointless.
> 
> The only reason a PHY ID should be defined in brcmphy.h is so that it can
> be used in the broadcom.c PHY driver or similar.
> 
> If there is no user in the tree, there is no reason to add it to the
> header file.

Ok, I will try to add the phy support in Broadcom phy driver. Thanks for your comment.

Regards,
Andy
