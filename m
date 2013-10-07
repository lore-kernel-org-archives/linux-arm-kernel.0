From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 7 Oct 2013 18:06:27 -0400 (EDT)
Subject: [PATCH 3/6] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <20131007140343.GA12030@localhost.localdomain>
References: <20131007140343.GA12030@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1310071804030.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013, Dave Martin wrote:

> On Fri, Oct 04, 2013 at 03:51:31PM -0400, Nicolas Pitre wrote:
> > No FIQs are supposed to ever race with this code.
> 
> There is an anomaly though: FIQ and external abort don't seem to get
> explicitly masked anywhere, either on the suspend or powerdown paths.
> Sometimes either or both remains unmasked (I tried some trace in the
> TC2 MCPM backend to confirm this.)
> 
> Looks like a possible omission in the arch/arm/ suspend and shutdown
> code, rather than a problem specific to MCPM.

Possibly, yes.

Feel free to post a patch.


Nicolas
