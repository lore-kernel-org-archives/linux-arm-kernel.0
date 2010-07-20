From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 20 Jul 2010 18:54:18 -0500
Subject: Your patch: ARM: AMBA: Add pclk definition for platforms using
	primecells
Message-ID: <0D753D10438DA54287A00B02708426976374051D65@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

Your patch added a new clock to the ep93xx platform called "apb_pclk".  This
clock was already available as "pclk" on that platform.

Since there are no users of "pclk" in the kernel I have no problems just
renaming it to "apb_pclk" and removing the dummy_apb_pclk that you added.

Would you like me to submit the ncessary patch or can you fix it?

Regards,
Hartley
