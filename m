From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Nov 2009 10:39:57 +0000
Subject: [PATCH 4/4] RealView: Add sparsemem support for the RealView
	PBX platform
In-Reply-To: <1257762846.21820.27.camel@pc1117.cambridge.arm.com>
References: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
	<20091015122209.739.42849.stgit@pc1117.cambridge.arm.com>
	<20091108174503.GB28368@n2100.arm.linux.org.uk>
	<1257760300.21820.23.camel@pc1117.cambridge.arm.com>
	<20091109101822.GA15646@n2100.arm.linux.org.uk>
	<1257762846.21820.27.camel@pc1117.cambridge.arm.com>
Message-ID: <20091109103957.GB15646@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2009 at 10:34:06AM +0000, Catalin Marinas wrote:
> I don't think it's worth the hassle anyway. If you have
> REALVIEW_HIGH_PHYS_OFFSET disabled and FLATMEM, you end up with only
> 256MB of RAM available, I don't really see a point in this
> configuration. With the new patch, if you don't like SPARSEMEM (maybe
> for benchmarking reasons), just enable REALVIEW_HIGH_PHYS_OFFSET.
> 
> So, are you OK with the latest patch?

In that case, yes.
