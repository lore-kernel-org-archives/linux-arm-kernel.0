From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 13:47:57 +0000
Subject: [PATCH 6/7] rtc: sa1100: enable clk support
In-Reply-To: <20120222132029.GC22562@n2100.arm.linux.org.uk>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <201202221229.17934.arnd@arndb.de>
 <20120222132029.GC22562@n2100.arm.linux.org.uk>
Message-ID: <201202221347.57881.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2012, Russell King - ARM Linux wrote:
> Eww.  No, just keep this hidden beneath the clk API.  Return a NULL
> clock for this device, and ensure that all the standard clk API
> functions know internally that that means 'no action required'.
> 
> There's no need to pollute drivers with this platform specific knowledge.

Good point, that does sound much cleaner than my suggestion.

Thanks,

	Arnd
