From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Nov 2016 14:44:05 -0600
Subject: [PATCH v28 9/9] Documentation: dt: chosen properties for arm64
 kdump
In-Reply-To: <20161124171413.GE7452@e104818-lin.cambridge.arm.com>
References: <20161124095523.6972-1-takahiro.akashi@linaro.org>
 <20161124095944.7167-1-takahiro.akashi@linaro.org>
 <20161124171413.GE7452@e104818-lin.cambridge.arm.com>
Message-ID: <20161130204405.a4k54zrhe36dpdlp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 05:14:13PM +0000, Catalin Marinas wrote:
> On Thu, Nov 24, 2016 at 06:59:44PM +0900, AKASHI Takahiro wrote:
> > From: James Morse <james.morse@arm.com>
> > 
> > Add documentation for
> > 	linux,crashkernel-base and crashkernel-size,
> > 	linux,usable-memory-range
> > 	linux,elfcorehdr
> > used by arm64 kdump to decribe the kdump reserved area, and
> > the elfcorehdr's location within it.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > [takahiro.akashi at linaro.org: added "linux,crashkernel-base" and "-size" ]
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: devicetree at vger.kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> 
> Rob, Mark, are you ok with this patch?

I'm leaving this one to Mark.

Rob
