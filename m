From: david.jander@protonic.nl (David Jander)
Date: Tue, 8 Mar 2011 12:40:23 +0100
Subject: [PATCHv2 1/2] ARM: mx51: Implement code to allow mx51 to enter WFI
In-Reply-To: <20110307180700.GQ29521@pengutronix.de>
References: <1299281399-32304-1-git-send-email-Dinh.Nguyen@freescale.com>
	<56132A77AB93C141BF06E6B96CA6CFEA19124C@039-SN1MPN1-004.039d.mgd.msft.net>
	<87oc5puwg3.fsf@lebrac.rtp-net.org>
	<56132A77AB93C141BF06E6B96CA6CFEA193F14@039-SN1MPN1-004.039d.mgd.msft.net>
	<87fwqyvrzf.fsf@lebrac.rtp-net.org>
	<56132A77AB93C141BF06E6B96CA6CFEA1940F8@039-SN1MPN1-004.039d.mgd.msft.net>
	<20110307180700.GQ29521@pengutronix.de>
Message-ID: <20110308124023.5a952d13@archvile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sascha,

On Mon, 7 Mar 2011 19:07:00 +0100
"s.hauer at pengutronix.de" <s.hauer@pengutronix.de> wrote:
>[...]
> > The current imx for-next tree is not booting on my Babbage board. Is
> > it okay for you with your HW. I'll have to debug the booting part
> > first.
> 
> Probably because other than kconfig states i.MX51 and i.MX53 cannot be
> compiled in one kernel. the for-next branch boots fine on my babbage.

Would you mind explaining (or pointing to an explanation) as to why this is
not supposed to work? Given the high level of compatibility between MX51 and
MX53, I'd say there must be a very good reason not to enable a single binary
kernel for both. Or is this just temporary brokenness?

Best regards,

-- 
David Jander
Protonic Holland.
