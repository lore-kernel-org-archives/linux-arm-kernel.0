From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 15:52:44 +0100
Subject: [PATCH 0/2] cpuidle fixes and cleanup
In-Reply-To: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
References: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
Message-ID: <20140701145244.GX32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 08:02:36PM +0530, Chander Kashyap wrote:
> This patch series fixes the cpuidle for different states. Also removes arm
> diagnostic and power register save/restore code as it is made generic.
> 
> Based on:
> ARM: save/restore diagnostic register on Cortex-A9 suspend/resume
>  http://www.spinics.net/lists/arm-kernel/msg340506.html

As there is an outstanding issue with this patch, we can't proceed with
this set of changes until we know what's going on there.

Also, bear in mind that I have changes which conflict with this in my
tree (which I've just updated.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
