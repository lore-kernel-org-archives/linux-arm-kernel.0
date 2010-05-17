From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 May 2010 17:29:27 +0100
Subject: [PATCH] arm: ARCH_REQUIRE_GPIOLIB selects GENERIC_GPIO
In-Reply-To: <0D753D10438DA54287A00B0270842697636F0E0A5F@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697636A7E9494@AUSP01VMBX24.collaborationhost.net>
	<20100412184904.GG3048@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B0270842697636D4B70AD@AUSP01VMBX24.collaborationhost.net>
	<20100412191506.GL3048@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B0270842697636ECB4E08@AUSP01VMBX24.collaborationhost.net>
	<20100506204305.GB26818@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B0270842697636EDF5797@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697636EFDBD17@AUSP01VMBX24.collaborationhost.net>
	<20100516144932.GA23961@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B0270842697636F0E0A5F@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100517162927.GB9304@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 11:20:02AM -0500, H Hartley Sweeten wrote:
> Added to patch system as Patch #6136.

Thanks, all merged and pushed out, with everything back that was dropped.

Now just need John's GENERIC_TIME patch and we're all set.

Thanks.
