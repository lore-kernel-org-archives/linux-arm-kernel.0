From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 May 2015 18:35:05 +0100
Subject: [PATCH 0/3] Three cleanup patches for proc-v7 code
Message-ID: <20150508173505.GL2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's three cleanup patches for the proc-v7 code which hopefully
improve the readability and add some additional documentation.

 arch/arm/mm/proc-v7.S | 162 ++++++++++++++++++++++++++++----------------------
 1 file changed, 91 insertions(+), 71 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
