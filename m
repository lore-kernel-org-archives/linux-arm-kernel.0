From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 May 2015 11:19:39 +0100
Subject: [PATCH 0/2] Fix Integrator for noMMU
Message-ID: <20150519101939.GB2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Here's the couple of patches which implement the idea I discussed over a
month ago to sort out the multiplatform-vs-noMMU issues around Integrator.
These have been sitting in my tree for most of that time, and have been
subjected to my autobuilder during that period.

Please merge these through arm-soc.

 arch/arm/Kconfig                 |  4 ++++
 arch/arm/mach-integrator/Kconfig |  3 +--
 arch/arm/mm/Kconfig              | 40 ++++++++++++++++++++++++++--------------
 3 files changed, 31 insertions(+), 16 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
