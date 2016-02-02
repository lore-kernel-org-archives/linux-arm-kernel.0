From: slash.tmp@free.fr (Mason)
Date: Tue, 2 Feb 2016 22:11:03 +0100
Subject: Plain DFS (no voltage scaling)
Message-ID: <56B11B67.3090600@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I plan to enable the on-demand governor on the tango platform:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/tango4-smp8758.dtsi

I found the cpufreq-dt binding doc:

https://www.kernel.org/doc/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
https://www.kernel.org/doc/Documentation/devicetree/bindings/opp/opp.txt

Something is not clear to me:

If my platform cannot scale the voltage, what information
should I put in the voltage part of the DT?

Regards.
