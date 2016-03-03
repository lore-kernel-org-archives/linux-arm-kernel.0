From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2016 10:50:05 +0000
Subject: [RFC PATCH] arm: kernel: pci: remove pci=firmware command line
 parameter handling
In-Reply-To: <20160303104845.GB28359@red-moon>
References: <1456767800-6609-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160229174258.GL5891@wantstofly.org>
 <20160301095832.GC31766@red-moon>
 <20160302223142.GS5891@wantstofly.org>
 <20160303104845.GB28359@red-moon>
Message-ID: <20160303105004.GU19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 10:48:45AM +0000, Lorenzo Pieralisi wrote:
> I think we should go ahead otherwise we are stuck forever with it,
> it is probably best for this patch to land in -next beginning of
> next cycle to unearth possible issues, that's the same thing
> we did for the latest changes in arm pcibios that we feared could
> trigger regressions.
> 
> Russell, what's your opinion on this ? Please let me know.

I'm happy with the suggested approach.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
