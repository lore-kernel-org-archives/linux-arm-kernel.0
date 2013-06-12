From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Jun 2013 19:33:31 +0800
Subject: [RFC PATCH v2 0/2] ARM: MPIDR linearization
In-Reply-To: <20130612091355.GB20236@e102568-lin.cambridge.arm.com>
References: <1370532125-14322-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130611095848.GD8164@e102568-lin.cambridge.arm.com>
 <20130612083619.GA13274@S2101-09.ap.freescale.net>
 <20130612091355.GB20236@e102568-lin.cambridge.arm.com>
Message-ID: <20130612113330.GB13274@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 10:13:55AM +0100, Lorenzo Pieralisi wrote:
> Thanks a lot. If you can enable idle deep C-states that would be grand,

We haven't added the power gating support in cpuidle, but only clock
gating so far.

Shawn

> S2R exercises that code path just on one CPU whilst idle clobbers it on
> all CPUs at once and ensures the hash is working properly on your platform.
