From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 10 Dec 2009 18:04:05 +0200
Subject: [CFT:PATCH] Remove a seemingly unnecessary cache flush
In-Reply-To: <20091207221210.GI26821@n2100.arm.linux.org.uk>
References: <20091207221210.GI26821@n2100.arm.linux.org.uk>
Message-ID: <4B211BF5.8040306@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

I've tested boot and hackbench on PXA270.

cm-debian:~# cat /proc/cpuinfo
Processor       : XScale-PXA270 rev 7 (v5l)
BogoMIPS        : 311.29
Features        : swp half thumb fastmult edsp iwmmxt
CPU implementer : 0x69
CPU architecture: 5TE
CPU variant     : 0x0
CPU part        : 0x411
CPU revision    : 7

Hardware        : Compulab CM-X2XX
Revision        : 0000
Serial          : 0000000000000000



-- 
Sincerely yours,
Mike.
