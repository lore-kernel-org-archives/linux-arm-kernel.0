From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 29 Dec 2010 17:51:48 +0800
Subject: [PATCH 03/10] net/fec: add mac field into platform data and
	consolidate fec_get_mac
In-Reply-To: <4D1AC71D.9020305@snapgear.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-4-git-send-email-shawn.guo@freescale.com>
	<4D1AC71D.9020305@snapgear.com>
Message-ID: <20101229095147.GA19347@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Wed, Dec 29, 2010 at 03:29:01PM +1000, Greg Ungerer wrote:
> Hi Shawn,
> 
> On 29/12/10 00:55, Shawn Guo wrote:
> >Add mac field into fec_platform_data and consolidate function
> >fec_get_mac to get mac address in following order.
> >
> >  1) kernel command line fec_mac=xx:xx:xx...
> >  2) from flash in case of CONFIG_M5272 or fec_platform_data mac
> >     field for others, which typically have mac stored in fuse
> 
> Looking at this we can move that 5272 specific code into its
> arch code with these changes. I can do that later if you don't
> want to do it in this series.
> 
It would be great if you can do that, since I do not have the
the platform to test anyway.

-- 
Regards,
Shawn
