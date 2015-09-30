From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 30 Sep 2015 14:04:30 +0100
Subject: [PATCH v5 00/22] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <560BCB67.1060100@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
 <20150930113214.GA10997@leverpostej> <560BCB67.1060100@citrix.com>
Message-ID: <20150930130429.GG10997@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Just to check, would this be expected to work with a 16K DomU (e.g.
> > [2])?
> > 
> > From a quick scan it looks like the relaxations provided by this series
> > should work so long as PAGE_SIZE % XEN_PAGE_SIZE == 0, assuming I
> > haven't missed something.
> 
> Correct, this series is able to cope with any PAGE_SIZE as long as it's
> a multiple of the granularity used by Xen (i.e 4KB on ARM).

[...]

> > Would any of these require more work to also handle 16K?
> 
> No. It should just boot on Xen as long as the CPU is support 16K
> granularity.

Great to hear, thanks!

Mark.
