From: mlweber1@rockwellcollins.com (mlweber1 at rockwellcollins.com)
Date: Wed, 4 Dec 2013 08:25:33 -0600
Subject: Moschip MCS8142 SoC
Message-ID: <OF433D4F00.CB35F8E7-ON86257C37.004F3E8D@rockwellcollins.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Has anyone happened to work with this Moschip SoC?  I found Linux BSP 
patches for the MCS8140 (OpenWRT 3.3 Kernel plus some initial attempts at 
mainlining around 3.7), however that MCS8140 SoC was a true ARMv5 compared 
to the MCS8142 which seems to be based on a Faraday fa526 ARMv4.  
Another item I'm not to sure about is if the bus and peripheral 
architecture are similar.

Any help is appreciated (reference docs that outline the register 
definition, etc.) .  We're trying to get a 3.x kernel running on this 
target to replace a older 2.6.24 blob that we can't get source for..... 

Matthew L Weber / Sr Software Engineer / Platform SW 
mlweber1 at rockwellcollins.com
