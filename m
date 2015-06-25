From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Jun 2015 11:02:45 +0100
Subject: [PATCH 0/2] ARM: /proc/atags: Export also for DT
In-Reply-To: <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20150625100244.GA7576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 09:50:05PM +0200, Pali Roh?r wrote:
> This patch adds support for DT "/atags" and stores ATAG structure to DT.
> 
> It depends on "ARM: /proc/cpuinfo: DT: Add support for Revision" patches.
> 
> Pali Roh?r (2):
>   arm: devtree: Save atags if are in DT atags field
>   arm: boot: store ATAG structure into DT atag field
> 
>  arch/arm/boot/compressed/atags_to_fdt.c |    6 +++++-
>  arch/arm/kernel/devtree.c               |    6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

What these patches are missing is a description of _why_ this is required
in any of the commit messages.  The commit messages seem to be describing
_what_ the change is doing, which is something that can be seen by reading
the patches, but it leaves the question of why this change is necessary
entirely open.

Please update the commit messages on the next patch revision.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
