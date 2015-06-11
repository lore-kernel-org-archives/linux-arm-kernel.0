From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Jun 2015 10:34:17 +0100
Subject: [PATCH v4] ARM: l2c: add options to overwrite prefetching behavior
In-Reply-To: <20150611112459.6590ab05@free-electrons.com>
References: <1432941541-18588-1-git-send-email-hauke@hauke-m.de>
 <20150610172100.230c0e71@free-electrons.com>
 <55788F6B.7060406@hauke-m.de>
 <20150611112459.6590ab05@free-electrons.com>
Message-ID: <20150611093417.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 11:24:59AM +0200, Thomas Petazzoni wrote:
> Dear Hauke Mehrtens,
> 
> On Wed, 10 Jun 2015 21:26:35 +0200, Hauke Mehrtens wrote:
> 
> > Thanks for asking, I did not know Russell's patch process, but Florian
> > guided me and now it is submitted, see
> > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8391/1
> 
> I tested your patch, and I'm not sure how it can work for you, because
> the changes made to the PREFETCH_CTRL register on the data/instruction
> prefetch bits are later overridden by changes made to the AUX_CTRL
> register.

There's also a patch I sent on May 14th which needs to be applied for this
to work, and fixes the above.

> How does your patch handles the fact that the prefetch data and
> prefetch instr are cloned between PREFETCH_CTRL and AUX_CTRL ?

It needs my patch.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
