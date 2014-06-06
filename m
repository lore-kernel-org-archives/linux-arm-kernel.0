From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Fri, 6 Jun 2014 14:01:53 +0200
Subject: [PATCH 6/9] usb: chipidea: add Berlin USB support
In-Reply-To: <53919E3A.7070008@gmail.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401983326-19205-7-git-send-email-antoine.tenart@free-electrons.com>
 <53919E3A.7070008@gmail.com>
Message-ID: <20140606120153.GC32416@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Fri, Jun 06, 2014 at 12:55:54PM +0200, Sebastian Hesselbarth wrote:
> On 06/05/2014 05:48 PM, Antoine T?nart wrote:
> >+
> >+static const struct of_device_id ci_hdrc_berlin_of_match[] = {
> >+	{ .compatible = "marvell,berlin-usb" },
> 
> Looking at the driver, I can see no Berlin-specific code at all. Maybe
> we just take the chance and have a generic chipidea boiler plate driver
> now?

This driver does nothing special. If we define the PHY and the clock
properties as optional, we can do a generic driver here.


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
