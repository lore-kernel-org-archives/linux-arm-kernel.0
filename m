From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Dec 2015 18:33:27 +0000
Subject: [PATCH] scripts: recordmcount: break hardlinks
In-Reply-To: <20151211131029.5bb23411@gandalf.local.home>
References: <20151202090517.432556a4@gandalf.local.home>
 <E1a7MVT-0000et-62@rmk-PC.arm.linux.org.uk>
 <20151211093125.50b72639@gandalf.local.home>
 <20151211144541.GT8644@n2100.arm.linux.org.uk>
 <20151211131029.5bb23411@gandalf.local.home>
Message-ID: <20151211183326.GV8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 01:10:29PM -0500, Steven Rostedt wrote:
> I ran it through most my tests (it's still running and is at 20 of 33
> tests). If there was anything wrong with this patch, I'm sure one of my
> tests would have crashed by now.

Thanks for testing.

> Do you want to take it, or shall I?

I'm easy - it probably makes more sense if take it.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
