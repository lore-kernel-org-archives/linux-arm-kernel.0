From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2011 15:14:11 +0000
Subject: rmk out of action until further notice
Message-ID: <20110303151411.GG25891@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... as Linux/Fedora has managed to completely trash my laptop with
massive filesystem corruption of its ext4fs.

Due to the extent of the corruption, I suspect I've lost my local copy
of the git tree, and as I haven't pushed it out for a few days, I
suspect there's going to be commits which even once I've recovered it
back off the 'net will be missing.  *Luckily* as the copies on the net
are rsync'd copies of the git objects, all the commits up until
Monday-ish should be retrievable.

(e2fsck is running with a weight on the 'y' key - and has been running
thusly for the last 15 minutes so far...)

As such, please don't pester about patches not being applied, or even
expect me to reply to emails until I've resolved this issue.
