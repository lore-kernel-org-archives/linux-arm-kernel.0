From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 1 Oct 2018 14:51:48 +0200
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
In-Reply-To: <0f80dc88-dffe-4ca6-bb85-c4e5c967e0e1@cesnet.cz>
References: <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <20180924101213.GO30658@n2100.armlinux.org.uk>
 <20180924122614.70738b5c@windsurf>
 <20180924111341.GP30658@n2100.armlinux.org.uk>
 <20180924141203.3df9707a@windsurf>
 <20180924124620.GA10322@e107981-ln.cambridge.arm.com>
 <20180924151040.5e57462b@windsurf>
 <20180924141512.GA11875@e107981-ln.cambridge.arm.com>
 <20180924165218.26c7c418@windsurf>
 <0f80dc88-dffe-4ca6-bb85-c4e5c967e0e1@cesnet.cz>
Message-ID: <20181001145148.158c6207@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 01 Oct 2018 12:56:37 +0200, Jan Kundr?t wrote:

> Thomas, Russell, Lorenzo,
> did you have time to convert this into a patch which can hit 4.19? I don't 
> see anything related in 4.19-rc6, but perhaps I missed something. Is there 
> something that I should test or otherwise help?

Sorry, I suddenly got busy (my second son arrived a few days earlier
than expected).

I just sent a proper patch with the proposal I made last week, after
testing on ClearFog and Armada XP GP. Note that on ClearFog, I only
tested that it fixes the panic at boot, since I didn't had any
mini-PCIe devices at hand. On Armada XP GP, I verified that an E1000E
NIC was still working as expected. Therefore, it would be useful if
you could test on your ClearFog platform with PCI devices connected.

Thanks a lot and sorry for the delay.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
