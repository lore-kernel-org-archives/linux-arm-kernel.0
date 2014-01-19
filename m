From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 Jan 2014 12:27:50 +0800
Subject: imx6 eSATA
In-Reply-To: <20140118211119.GA6618@n2100.arm.linux.org.uk>
References: <20140118184427.GJ15937@n2100.arm.linux.org.uk>
 <20140118190337.GK15937@n2100.arm.linux.org.uk>
 <20140118211119.GA6618@n2100.arm.linux.org.uk>
Message-ID: <20140119042746.GA22423@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 18, 2014 at 09:11:19PM +0000, Russell King - ARM Linux wrote:
> Sigh.  You can't get rid of the of_node there because it's needed
> for clk_get() inside ahci_platform.c.  So, I think ahci_platform needs
> to become yet another library, and thereby avoid creating a child
> platform device.

Yes, you're right.  This has been discussed for a while [1].

Shawn

[1] http://thread.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/4835/focus=4909
