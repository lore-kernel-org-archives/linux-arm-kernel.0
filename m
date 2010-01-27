From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 27 Jan 2010 00:29:04 +0000
Subject: [PATCH 01/10] ARM: LPC32XX: Changes to existing files to
	support the LPC32XX architecture
In-Reply-To: <1264551574.6528.4@usb10132>
References: <1264551574.6528.4@usb10132>
Message-ID: <20100127002904.GG9153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 04:19:34PM -0800, Kevin Wells wrote:
> Changes to existing files to support the new LPC32XX architecture

Please don't post patches across multiple susbsytems, they're a pain
to merge. Please break the i2c and wdt bits out of this patch.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
