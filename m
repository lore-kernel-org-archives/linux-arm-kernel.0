From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Feb 2010 20:01:56 +0000
Subject: [RESEND PATCH] ARM: oprofile: convert from sysdev to platform
	device
In-Reply-To: <1267183469-4371-1-git-send-email-aaro.koskinen@nokia.com>
References: <1267183469-4371-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <20100226200156.GB23933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2010 at 01:24:29PM +0200, Aaro Koskinen wrote:
> oprofile does not work with PM, because sysdev_suspend() is done with
> interrupts disabled and oprofile needs a mutex. Implementing oprofile
> as a platform device solves this problem.

I've not been tempted to do anything with this because there's other
people working on the oprofile code - see the perf/oprofile discussions
on LAK.
