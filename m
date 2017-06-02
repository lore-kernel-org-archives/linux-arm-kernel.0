From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Jun 2017 10:36:51 +0100
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <2b63fe63-0ffd-34f8-1966-3f3c803d640a@xs4all.nl>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
 <e254fcf9-79bc-4ffc-284f-e52c80069fe3@synopsys.com>
 <20170601223054.GH22219@n2100.armlinux.org.uk>
 <b1540ab1-8343-81c6-689f-fa85831680a8@synopsys.com>
 <20170602091528.GJ22219@n2100.armlinux.org.uk>
 <2b63fe63-0ffd-34f8-1966-3f3c803d640a@xs4all.nl>
Message-ID: <20170602093651.GL22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 11:28:08AM +0200, Hans Verkuil wrote:
> The 'signal_free_time' argument of adap_transmit will have the recommended
> signal free time. You can test against the CEC_SIGNAL_FREE_TIME_* defines
> from media/cec.h. You probably saw this already, but just in case you missed
> this...

Yes, it's a recent addition to the CEC core, which I've added support
for, but it doesn't make too much sense until the retrying stuff is
sorted out.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
