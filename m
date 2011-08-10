From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Aug 2011 10:22:06 +0100
Subject: Enabling runtime P2V by default (Re: [PATCH 3/5] mach-u300:
	patch physoffset by default)
In-Reply-To: <20110810091635.GF1831@n2100.arm.linux.org.uk>
References: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
	<20110810091635.GF1831@n2100.arm.linux.org.uk>
Message-ID: <20110810092206.GE10121@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 10:16:35AM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 09, 2011 at 09:41:38PM +0200, Linus Walleij wrote:
> > From: Linus Walleij <linus.walleij@linaro.org>
> > 
> > This works like a charm so I'll just default-select it.
> 
> Well, we can remove the EXPERIMENTAL status of this option now.  This
> raises the question is whether we should now default it to 'y' - I
> think we should.  Anyone have any objections?

I've been running with this option enabled for the collection of ARM boards
I have and the only problem I have encountered was related to u-boot loading
at the wrong address.

So I'm all for enabling it by default, especially since it will force out
any remaining issues for boards where this hasn't been used extensively.

Will
