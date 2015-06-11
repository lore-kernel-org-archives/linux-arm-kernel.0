From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Jun 2015 11:47:31 +0200
Subject: [PATCH v4] ARM: l2c: add options to overwrite prefetching behavior
In-Reply-To: <20150611093907.GW7557@n2100.arm.linux.org.uk>
References: <1432941541-18588-1-git-send-email-hauke@hauke-m.de>
 <20150610172100.230c0e71@free-electrons.com>
 <55788F6B.7060406@hauke-m.de>
 <20150611112459.6590ab05@free-electrons.com>
 <20150611093417.GV7557@n2100.arm.linux.org.uk>
 <20150611093907.GW7557@n2100.arm.linux.org.uk>
Message-ID: <20150611114731.23147349@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Thu, 11 Jun 2015 10:39:07 +0100, Russell King - ARM Linux wrote:

> > > How does your patch handles the fact that the prefetch data and
> > > prefetch instr are cloned between PREFETCH_CTRL and AUX_CTRL ?
> > 
> > It needs my patch.
> 
> ... in fact, please see all the other L2C patches queued in my tree.
> Hauke's patch is designed to be applied on top of these patches, not
> to 4.1-rc directly.

Yes, right. In the mean time, I discovered the discussion you had with
Hauke on the v2 of his patch series, and started looking at your
for-next branch. I wanted to give a test before reporting back, and
it's now done: with "ARM: l2c: write auxiliary control register first"
+ Hauke's patch, it works fine for me.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
