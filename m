From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jul 2018 21:50:04 +0100
Subject: [PATCH net-next 0/4] Further ARM BPF jit compiler improvements
Message-ID: <20180712205003.GU17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Four further jit compiler improves for 32-bit ARM.

 arch/arm/net/bpf_jit_32.c | 120 ++++++++++++++++++++++++++++------------------
 1 file changed, 73 insertions(+), 47 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
