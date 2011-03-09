From: will.deacon@arm.com (Will Deacon)
Date: Wed, 09 Mar 2011 21:58:59 +0000
Subject: [PATCH] ARM: hw_breakpoint: Fix newlines in WARNings
In-Reply-To: <4D77D6CB.402@codeaurora.org>
References: <1298633466.32588.1.camel@e102144-lin.cambridge.arm.com>
	<1298693163-18269-1-git-send-email-sboyd@codeaurora.org>
	<4D77D6CB.402@codeaurora.org>
Message-ID: <1299707939.4971.1.camel@jazzbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-09 at 19:36 +0000, Stephen Boyd wrote:
> Will,

Hi Stephen,
> 
> On 02/25/2011 08:06 PM, Stephen Boyd wrote:
> > Will Deacon wrote:
> >>> I'd prefer the message text not to be line wrapped, even if it
> >>> violates the general line length rule, because that makes it easier to
> >>> grep for the message in the source code.
> >> Ok, that's understandable. Moving the text onto its own line will limit
> >> the damage to the line length too. Stephen - are you happy to make these
> >> changes as part of your previous patch?
> >
> 
> Do you want to take this? I'm going to submit it to the patch tracker
> tomorrow otherwise.

Please submit it to the patch system with my ack:

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
