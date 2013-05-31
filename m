From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 31 May 2013 15:16:33 -0700
Subject: [PATCHv6 00/11] Remove ARM local timer API
In-Reply-To: <51A8E71D.1000407@linaro.org>
References: <1368473175-4841-1-git-send-email-sboyd@codeaurora.org>
 <20130531174526.GD599@codeaurora.org> <51A8E71D.1000407@linaro.org>
Message-ID: <20130531221633.GG599@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31, John Stultz wrote:
> On 05/31/2013 10:45 AM, Stephen Boyd wrote:
> >Comments have been light for this round so I think we're about
> >ready to merge. John/Thomas, can you pick up these patches or
> >shall I route them through arm-soc or something else?
> 
> 
> So there looks to be a fair amount of additions in the ARM tree, do
> those already have acks from Arnd/Olof/other folks? (I think I was
> only cc'ed on the first two patches).

I'm still missing acks from Kukjin and Barry.

> 
> Daniel (cc'ed) has just started helping out here, and should be able
> to review and hopefully ack or pick up the timer related
> drivers/clocksource changes to feed to Thomas' tree. Not sure if
> he's got them in his mailbox so you might want to resend them and
> make sure he's CC'ed.
> 
> If Arnd/Olof/whomever else from the arm side has acked things,
> Daniel probably could queue the arm changes too, but it might be
> better just to get Daniel's ack on the drivers/clocksource changes
> and then queue things via arm-soc?

Either way works for me. I would just like to see this merged
into 3.11. I guess I will resend one more time.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
