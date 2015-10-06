From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 16:34:10 +0200
Subject: [GIT PULL] SoCFPGA DTS updates for v4.4
In-Reply-To: <1444125744-21798-1-git-send-email-dinguyen@opensource.altera.com>
References: <1444125744-21798-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <6510812.tHLFEUGyjH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 05:02:24 dinguyen at opensource.altera.com wrote:
> Hi Arnd, Kevin, and Olof,
> 
> Please consider pulling these patches for v4.4. For the arm64 patch, I don't
> have an official ACK from the DTS guys, but I did get an "its looks okay"
> with a condition that I fix up the ranges property for /soc node.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/372136.html
> 
> 

Looks ok, merged into next/dt now.

I see one commit for the defconfig file. We normally put those into a separate
branch with just defconfig changes, to avoid merge conflicts, but it doesn't
seem worth to make you redo the pull request for that. Please do that next
time though.

	Arnd
