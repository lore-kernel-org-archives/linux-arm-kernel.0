From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 22 Jul 2014 11:11:26 +0100
Subject: [PATCH v2] bus: ARM CCN PMU driver
In-Reply-To: <1405091188-31754-1-git-send-email-pawel.moll@arm.com>
References: <1405091188-31754-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1406023886.25343.48.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof, 

On Fri, 2014-07-11 at 16:06 +0100, Pawel Moll wrote:
> Driver providing perf backend for ARM Cache Coherent Network
> interconnect. Supports counting all hardware events and crosspoint
> watchpoints.
> 
> Currently works with CCN-504 only, although there should be
> no changes required for CCN-508 (just impossible to test it now).
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Would you consider taking this through arm-soc tree? There isn't
anything in MAINTAINERS, but I vaguely remember Arnd proposing this
directory in the first place...

Cheers!

Pawel
