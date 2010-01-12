From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 12 Jan 2010 10:23:10 -0800
Subject: [RFC 08/18] arm: msm: set L2CR1 to enable prefetch
	andburstonScorpion.
In-Reply-To: <1263307279.29654.102.camel@pc1117.cambridge.arm.com>
References: <20100111234540.GN7925@n2100.arm.linux.org.uk>
	<1263293501.29654.40.camel@pc1117.cambridge.arm.com>
	<20100112114441.GB27771@n2100.arm.linux.org.uk>
	<1263303176.29654.71.camel@pc1117.cambridge.arm.com>
	<20100112135859.GF27771@n2100.arm.linux.org.uk>
	<1263307279.29654.102.camel@pc1117.cambridge.arm.com>
Message-ID: <1263320590.3497.3.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-12 at 14:41 +0000, Catalin Marinas wrote:
> My argument was that ACTLR is implementation-defined, so other cores
> like Scorpion may have a different meaning for such bits (Daniel's
> patches are probably held in the moderation queue, I only saw your
> replies). 

Yeah, they are being held for moderator approval ("Message has a
suspicious header") .. I see a lot of other patchsets going through,
does anyone have a location for the right method to submit a series to
this list?

Daniel
