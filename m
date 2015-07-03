From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jul 2015 12:02:49 +0100
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <20150703105441.GF1521@katana>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
Message-ID: <20150703110249.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 03, 2015 at 12:54:41PM +0200, Wolfram Sang wrote:
> Enabling all lockdep features doesn't show anything for the non-working
> case. However, I get warning for the working case:

Please share your .config file for this case.  Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
