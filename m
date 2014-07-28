From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 27 Jul 2014 22:31:15 -0700
Subject: [PATCHv4 0/5] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <1402579245-13377-1-git-send-email-LW@KARO-electronics.de>
References: <1402579245-13377-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140728053115.GB3095@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 03:20:40PM +0200, Lothar Wa?mann wrote:
> With a flash-based BBT there is no reason to move the Factory Bad
> Block Marker from the data area buffer (to where it is mapped by the
> GPMI NAND controller) to the OOB buffer. Thus, make this feature
> configurable via DT. This is required for the Ka-Ro electronics
> i.MX6 platforms.

Pushed patches 1-3 to l2-mtd.git. Thanks!

Brian
