From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 21 Nov 2012 16:59:46 +0100
Subject: [PATCH] Dove: Attempt to fix PMU/RTC interrupts
In-Reply-To: <20121118162944.GV3290@n2100.arm.linux.org.uk>
References: <20121118162944.GV3290@n2100.arm.linux.org.uk>
Message-ID: <20121121155946.GU10259@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2012 at 04:29:44PM +0000, Russell King - ARM Linux wrote:
> Fix the acknowledgement of PMU interrupts on Dove: some Dove hardware
> has not been sensibly designed so that interrupts can be handled in a
> race free manner.  The PMU is one such instance.

Hi Russel

I checked with Marvell. They confirmed there is no race free way to
clear these interrupts :-(

   Andrew
