From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 12 Aug 2013 11:22:07 +0800
Subject: [PATCH 1/1] arm: imx: Kconfig: select syscon for mx25
In-Reply-To: <20130812050126.GA25061@S2101-09.ap.freescale.net>
References: <1375947809-11694-1-git-send-email-peter.chen@freescale.com>
 <20130812050126.GA25061@S2101-09.ap.freescale.net>
Message-ID: <20130812032206.GA22626@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 01:01:28PM +0800, Shawn Guo wrote:
> I prefer to use uppercase for "ARM:" in subject.
> 
> On Thu, Aug 08, 2013 at 03:43:29PM +0800, Peter Chen wrote:
> > We need to use syscon to map one register region for several
> > devices, eg, usb non-core register for all usb devices.
> 
> So we're changing usb non-core controller to be a syscon?
> 

Please forget this patch.

Sascha suggested another patch avoiding using syscon, and changing
binding.

-- 

Best Regards,
Peter Chen
