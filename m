From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 28 Mar 2014 15:27:47 +0000
Subject: [ARM ATTEND] Following discussions, device tree, ARM64
Message-ID: <20140328152747.GC14113@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As one of the device tree bindings maintainers and as someone involved in arm64
Linux development, I am interested in attending the ARM mini summit for the
purpose of discussing:

* ARM64 SoC support, and questions/plans regarding upstreaming and code sharing
  with arm.

* Device tree cleanup. There are currently many bindings and dts files which
  serve as poor examples, but changes to bring them into line with
  standards would involve breaking support for existing DTBs. We don't have
  good mechanisms for deprecation of bindings; doubly so for those which are
  widely used. How can we avoid/ameliorate this in future?

* Device tree stabilisation. There are currently plans to move stable bindings
  and/or dts out of the kernel tree and into a separate repo. How will stable
  bindings and/or dts be chosen, and what does this mean for bindings left in the
  kernel with regards to stability/deprecation?

In addition to following general discussions.

Cheers,
Mark.
