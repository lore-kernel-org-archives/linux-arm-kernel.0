From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Aug 2016 16:26:48 +0200
Subject: [PATCH 0/4] arm64: marvell: add support for the PIC and PMU
In-Reply-To: <20160816141447.GQ3353@io.lakedaemon.net>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160816141447.GQ3353@io.lakedaemon.net>
Message-ID: <20160817162648.50eeeb83@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 16 Aug 2016 14:14:47 +0000, Jason Cooper wrote:

> Patches 1-3 applied to irqchip/mvebu64.  Patch 1 has Rob's Ack.

Great, thanks! Did you fix the driver for the minor nit that you
pointed out, or do you want a follow-up to fix that?

> I assume you'll route the dtsi change through a separate branch.

Yes, Gregory will take care of the .dtsi change, and pass it through
mvebu and arm-soc.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
