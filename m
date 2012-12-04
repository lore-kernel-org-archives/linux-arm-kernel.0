From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Dec 2012 20:46:54 +0100
Subject: [PATCH] arm: mvebu: Use dw-apb-uart instead of ns16650 as UART
 driver
In-Reply-To: <20121204194501.GT12509@titan.lakedaemon.net>
References: <1354640699-6066-1-git-send-email-gregory.clement@free-electrons.com>
 <50BE2E22.6020606@free-electrons.com>
 <20121204194501.GT12509@titan.lakedaemon.net>
Message-ID: <20121204204654.2a915160@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 4 Dec 2012 14:45:01 -0500, Jason Cooper wrote:

> > > This patch fixed a bug introduced in 3.7, but as there are very
> > > few boards supported in 3.7 (only the Armada 370 and Armada XP
> > > evaluation boards), it is not a big deal if this patch is only
> > > applied for 3.8.
> 
> mirabox, openblocks A3/4, but your point still stands.

No, there was no support in mainline for the Mirabox or OpenBlocks in
3.7. The support for those boards has been introduced for 3.8.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
