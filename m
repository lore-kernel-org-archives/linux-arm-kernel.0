From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jan 2010 08:42:03 +0000
Subject: [PATCH 0/7] dma-mapping: Cortex A9 speculative prefetch fixes
In-Reply-To: <f20fa6c61001122237o44b1fc96jd3a0481cd5df6188@mail.gmail.com>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
	<20091121140037.GI6741@wear.picochip.com>
	<20091123102955.GB16050@n2100.arm.linux.org.uk>
	<f20fa6c61001122237o44b1fc96jd3a0481cd5df6188@mail.gmail.com>
Message-ID: <20100113084203.GA23367@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 10:37:27PM -0800, muni anda wrote:
> Hi Russell,
> 
> > We're a little too late for 2.6.32, but it'll be merged
> > during the post 2.6.32 window.
> 
> Did these "Cortex speculative Prefetch" changes made it into ARM git?
> You changes are working on our end for quite some time, but would like
> to cherry-pick or merge the upstream commits.

No, it's far too large to merge during the -rc period.  It is going to
have to wait for the next merge window.
