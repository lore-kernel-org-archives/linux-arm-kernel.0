From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Apr 2014 10:14:30 +0100
Subject: [PATCH 3/5] arm: Disable preemption in iwmmxt_task_enable()
In-Reply-To: <1394734552-4704-4-git-send-email-catalin.marinas@arm.com>
References: <1394734552-4704-1-git-send-email-catalin.marinas@arm.com>
 <1394734552-4704-4-git-send-email-catalin.marinas@arm.com>
Message-ID: <20140410091429.GA24315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 06:15:50PM +0000, Catalin Marinas wrote:
> This patch is in preparation for calling the iwmmxt_task_enable()
> function with interrupts enabled.

This patch isn't even build-tested and causes build regressions due to
lack of an include.  Therefore, I'm dropping the whole series.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
