From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Mar 2015 17:19:41 +0000
Subject: [FOR DISCUSSION 0/9] Dove PMU support
In-Reply-To: <1466359.8taRhRkKWI@vostro.rjw.lan>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <1824813.kJQ02QuMbA@vostro.rjw.lan>
 <20150320121659.GJ8656@n2100.arm.linux.org.uk>
 <1466359.8taRhRkKWI@vostro.rjw.lan>
Message-ID: <20150320171941.GK8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 01:44:30PM +0100, Rafael J. Wysocki wrote:
> Both work for me, actually.  I think that Kevin has ACKed the patch despite
> the comments, so it would be fine to apply it I guess.

Here's the set of three - with the second one reworked.

 drivers/base/power/domain.c | 58 +++++++++++++++++++++++++++++----------------
 include/linux/pm_domain.h   |  6 ++---
 2 files changed, 40 insertions(+), 24 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
