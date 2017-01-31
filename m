From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2017 10:21:20 +0000
Subject: [PATCH v3 00/24] i.MX Media Driver
In-Reply-To: <951c1a08-c0f2-4333-b4bf-410de8dd863f@gmail.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <20170131004510.GQ27312@n2100.armlinux.org.uk>
 <951c1a08-c0f2-4333-b4bf-410de8dd863f@gmail.com>
Message-ID: <20170131102120.GS27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 05:22:01PM -0800, Steve Longerbeam wrote:
> Edit: I see a subdev that is missing: the video mux. Did you enable
> CONFIG_VIDEO_MULTIPLEXER?

Yes, and that's where the problem is - the video-multiplexer is 
missing the module aliases to allow it to be automatically loaded.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
