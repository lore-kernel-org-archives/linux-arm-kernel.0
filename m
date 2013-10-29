From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Oct 2013 22:05:49 -0700
Subject: [PATCH 3/6] ARM: Add Krait L2 accessor functions
In-Reply-To: <20131029013230.GI4763@kartoffel>
References: <1383006690-6754-1-git-send-email-sboyd@codeaurora.org>
 <1383006690-6754-4-git-send-email-sboyd@codeaurora.org>
 <20131029011942.GG4763@kartoffel> <526F0DB5.8050800@codeaurora.org>
 <20131029013230.GI4763@kartoffel>
Message-ID: <20131029050548.GB21983@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28, Mark Rutland wrote:
> On Tue, Oct 29, 2013 at 01:21:57AM +0000, Stephen Boyd wrote:
> > On 10/28/13 18:19, Mark Rutland wrote:
> > > It might be worth commmenting inline as to what register each of these is
> > > accessing. Inevitably the commit message will become harder to find and
> > > associate with the code over time.
> > >
> > > Similarly for get_l2_indirect_reg.
> > 
> > Do you mean with the "@" syntax in the assembly? The 80-character limit
> > is out to get me.
> 
> I probably didn't mean inline :)
> 
> How about a block comment above the first asm block like:
> 
> /*
>  * Select the L2 window by poking l2cpselr, then write to the window via
>  * l2cpdr.
>  */
> 

Ok sure.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
