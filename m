From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jan 2017 14:51:37 +0000
Subject: [PATCH] ARM: imx6: add support for SolidRun Hummingboard2
In-Reply-To: <20170108135830.22595-1-dev@lynxeye.de>
References: <20170108135830.22595-1-dev@lynxeye.de>
Message-ID: <20170108145137.GR14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2017 at 02:58:30PM +0100, Lucas Stach wrote:
> Aka: Hummingboard Edge and Hummingboard Gate
> 
> This currently only supports the pieces I was able to test:
> - RTC
> - SD card with UHS modes
> - eMMC
> - SGTL5000 sound
> - All standard host USB ports
> - mini PCIe
> - IR receiver
> - HDMI output
> 
> Functions routed out to the pin headers are not enabled and have
> not been tested.

It would be nice if you talked to me or at least Jon, as I'm SolidRun's
"official" path to getting support for their boards merged - and rather
than having a Lucas special independently created DT file merged, we
can have one which closer resembles the one in the SolidRun tree.

I know working with manufacters isn't seen to be a good thing to do
in Open Source, but it would really help if people did at least try.

I've been holding off on the HB2 DT patches because there's changes I
needed which I need to talk to Jon about before I send them upstream.

You can find the changes in my "hb2" branch.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
