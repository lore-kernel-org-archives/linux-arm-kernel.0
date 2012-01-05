From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jan 2012 22:04:30 +0800
Subject: [PATCH v4] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <20120105130253.GA2562@pengutronix.de>
References: <1325766081-27864-1-git-send-email-lauri.hintsala@bluegiga.com>
 <4F059BCB.9050504@bluegiga.com>
 <20120105130253.GA2562@pengutronix.de>
Message-ID: <20120105140428.GG1729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 02:02:53PM +0100, Wolfram Sang wrote:
> 
> > Shawn: Should we temporary add following lines into headers? Any
> > better suggestions?
> 
> Why can't we simply use HW_DIGCTL_CHIPID? This register is at 0x8001c310
> for both, MX23 and MX28.
> 
This is a fairly good suggestion.  I will try to sort it out tomorrow.

-- 
Regards,
Shawn
