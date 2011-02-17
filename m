From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Feb 2011 19:17:25 +0200
Subject: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
In-Reply-To: <4D5D5770.9020501@ti.com>
References: <4D5D25F9.8030907@ti.com>
	<20110217151527.GL22356@legolas.emea.dhcp.ti.com>
	<20110217151804.GM22356@legolas.emea.dhcp.ti.com>
	<4D5D3D0B.8090106@ti.com>
	<20110217152648.GO22356@legolas.emea.dhcp.ti.com>
	<4D5D44AF.5050805@ti.com> <20110217162000.GP20795@atomide.com>
	<20110217162209.GA13425@legolas.emea.dhcp.ti.com>
	<20110217165953.GR20795@atomide.com> <4D5D5770.9020501@ti.com>
Message-ID: <20110217171725.GB14574@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 06:14:24PM +0100, Cousson, Benoit wrote:
> On 2/17/2011 5:59 PM, Tony Lindgren wrote:
> >* Felipe Balbi<balbi@ti.com>  [110217 08:20]:
> >>On Thu, Feb 17, 2011 at 08:20:01AM -0800, Tony Lindgren wrote:
> >>>
> >>>Maybe no need to rebase, I'll apply Benoit's series first into
> >>>omap-for-linus, then let's applying the other hwmod related patches
> >>>should be trivial.
> >>
> >>So I can drop the omap4 HWMOD part from my branch ?
> >
> >Yeh assuming Benoit's data is correct.
> 
> Of course, it is :-)
> 
> Then I will add USB in my series.

Cool, my for-tony branch has been updated without OMAP4 HWMOD data.

-- 
balbi
