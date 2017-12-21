From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 21 Dec 2017 16:12:01 +0800
Subject: [PATCH RESEND v6 0/6] provide power off support for iMX6 with
 external PMIC
In-Reply-To: <20171206184844.uqbu6rmj4bponpuw@sirena.org.uk>
References: <20171206072402.11694-1-o.rempel@pengutronix.de>
 <20171206184844.uqbu6rmj4bponpuw@sirena.org.uk>
Message-ID: <20171221081200.GK23230@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 06:48:44PM +0000, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 08:23:56AM +0100, Oleksij Rempel wrote:
> > 2017.12.06:
> > Adding Linus. Probably there is no maintainer for this patch set.
> > No changes are made, tested on v4.15-rc1.
> 
> Have any of the i.MX maintainers said anything about this?  I was about
> to reply to this asking if they were ever going to review it as it keeps
> on getting resent but I'm not seeing any interest from any of them but
> the main immediate audience is i.MX systems.

I will be happy to take the dts changes, after kernel/reboot and
regulator get accepted (ideally landed on mainline).

Shawn
