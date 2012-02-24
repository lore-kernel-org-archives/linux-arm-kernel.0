From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Feb 2012 10:37:45 +0000
Subject: [PATCH v2 3/4] arm/dts: OMAP4: Add mmc controller nodes and
 board data
In-Reply-To: <4F4765EC.1000102@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
 <1329998490-27555-4-git-send-email-rnayak@ti.com>
 <CANrkHUaP7cV_vSKQYZkeF-aS5CEi2CAp3_9aDJKCVOX-67oNPg@mail.gmail.com>
 <4F4765EC.1000102@ti.com>
Message-ID: <20120224103745.GI22675@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 03:56:52PM +0530, Rajendra Nayak wrote:
> I don't know if we can, but even if we could, we take care of the same
> bootargs working on two boards (say sdp and panda) *if* on sdp I have my
> filesystem on eMMC and on panda I have it on external card.
> What happens if I want to use my filesystem on both boards on external
> card?

This is why the bootargs should be part of the information the boot
loader passes to the kernel, and not part of the kernel configuration
or DT.
