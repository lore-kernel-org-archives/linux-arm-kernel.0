From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 05 Jul 2012 10:25:20 +0100
Subject: [PATCH 2/2] ARM: vexpress: remove automatic errata workaround
 selection
In-Reply-To: <1341414076-20895-2-git-send-email-will.deacon@arm.com>
References: <1341414076-20895-1-git-send-email-will.deacon@arm.com>
 <1341414076-20895-2-git-send-email-will.deacon@arm.com>
Message-ID: <1341480320.1173.25.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-04 at 16:01 +0100, Will Deacon wrote:
> The vexpress Kconfig setup tries to be clever^Whelpful and selects some
> errata workarounds for certain revisions of the Cortex-A9 and PL310,
> which may be required depending on the coretile.
>
> Since the mach-vexpress can support A5, A7 and A15 coretiles, let's
> defer errata workaround selection to the user and instead propose
> recommended workarounds in the defconfig. Note that the use of the
> savedefconfig target removed some unrelated, redundant entries from the
> file.

I'm fine with that if no one objects. Will add it to the VE updates for
3.6 merge window.

Pawe?
