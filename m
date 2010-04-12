From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 19:39:58 +0100
Subject: [RFC PATCH v5 1/2] ARM: VFP: fix the SMP versions of
	vfp_{sync,flush}_hwstate
In-Reply-To: <22a151b1b25c683fa8b59e6b2b95b6321909d0bf.1270199787.git.imre.deak@nokia.com>
References: <1270070606-5732-1-git-send-email-imre.deak@nokia.com>
	<cover.1270199787.git.imre.deak@nokia.com>
	<22a151b1b25c683fa8b59e6b2b95b6321909d0bf.1270199787.git.imre.deak@nokia.com>
Message-ID: <20100412183958.GC3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 05:36:02PM +0300, imre.deak at nokia.com wrote:
> From: Imre Deak <imre.deak@nokia.com>
> 
> Recently the UP versions of these functions were refactored and as
> a side effect it became possible to call them for the current thread.
> This isn't true for the SMP versions however, so fix this up.

This look safe to me; thanks.
