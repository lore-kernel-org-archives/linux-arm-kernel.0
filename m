From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 25 Oct 2011 02:44:41 -0600 (MDT)
Subject: [PATCH v5 3/7] arm: perf: support device with other non-irq
	resources
In-Reply-To: <20111025083420.GA6184@mudshark.cambridge.arm.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-4-git-send-email-ming.lei@canonical.com>
	<20111024150814.GA4771@mudshark.cambridge.arm.com>
	<CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
	<20111025083420.GA6184@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.00.1110250242130.27118@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Oct 2011, Will Deacon wrote:

> Hurrah! If you can get the OMAP / hwmod bits acked by the OMAP guys then I'm
> happy to take the perf and PMU changes into my tree.

I'd suggest that you take the perf/PMU stuff yourself if you are happy 
with it, and then we'll deal with the OMAP bits ourselves, since it looks 
like they aren't dependent on each other, and the OMAP parts will need 
changes.


- Paul
