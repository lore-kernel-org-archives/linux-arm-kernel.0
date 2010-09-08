From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Sep 2010 15:37:00 +0100
Subject: [PATCH 3/3] ARM: vexpress: add support for CPU hotplug to
	ct-ca9x4 tile
In-Reply-To: <1282060684-27761-4-git-send-email-will.deacon@arm.com>
References: <1282060684-27761-1-git-send-email-will.deacon@arm.com>
	<1282060684-27761-2-git-send-email-will.deacon@arm.com>
	<1282060684-27761-3-git-send-email-will.deacon@arm.com>
	<1282060684-27761-4-git-send-email-will.deacon@arm.com>
Message-ID: <20100908143700.GB32659@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 04:58:04PM +0100, Will Deacon wrote:
> The Versatile Express platform can support a quad-core Cortex-A9 tile running
> SMP Linux.
> 
> This patch adds support for CPU hotplug when running in this configuration.

This ties the core tile support into the generic versatile express code,
something which the current code structure is careful to avoid.  Please
ensure that we continue to avoid making the generic code rely upon
CA9x4 code.
