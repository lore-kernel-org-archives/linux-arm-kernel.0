From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2016 14:45:00 +0100
Subject: [PATCH v2] ARM: reboot: remove duplicated local_irq_disable()
In-Reply-To: <20160427172211.395b846a@xhacker>
References: <1459320308-4584-1-git-send-email-jszhang@marvell.com>
 <20160427172211.395b846a@xhacker>
Message-ID: <20160428134500.GD19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 05:22:11PM +0800, Jisheng Zhang wrote:
> Dear Russell,
> 
> On Wed, 30 Mar 2016 14:45:08 +0800 Jisheng Zhang wrote:
> 
> > Once entering machine_halt() and machine_restart(), local_irq_disable()
> > is called, and local irq is kept disabled, so the local_irq_disable()
> > at the end of these two functions are not necessary, remove it.
> 
> Could I put the patch in your patch tracking system?

Yes please.  Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
