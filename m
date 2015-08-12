From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Aug 2015 22:05:43 +0100
Subject: My boot farm
In-Reply-To: <20150812073515.GE7557@n2100.arm.linux.org.uk>
References: <20150812073515.GE7557@n2100.arm.linux.org.uk>
Message-ID: <20150812210543.GL7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 08:35:15AM +0100, Russell King - ARM Linux wrote:
> ... will be offline for a while as, on the face of it, the Digi TS16
> rack (terminal server) internal power supply seems to have died.  I'll
> investigate further on Friday, but in the mean time, I'm taking the
> boot tests completely offline until it's resolved.

It turns out that I had more time today than I expected to look at it.
What's died in it is the open-frame switch-mode PSU, ITS UO01511120,
which supplies 12V 1.3A to the main board - which looks to be due to
a manufacturing error in component placement.

In the mean time, I've jury-rigged an alternative 12V power source for
the main board in the terminal server, so the boot farm should be back
up and running tonight, provided all the RJ45's found their correct
holes. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
