From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Jun 2013 17:09:07 +0100
Subject: [PATCHv2 0/6] Make ARM's sched_clock generic + 64 bit friendly
In-Reply-To: <51AD32A4.5070609@linaro.org>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
 <51AD32A4.5070609@linaro.org>
Message-ID: <20130604160907.GW27516@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 01:19:48AM +0100, John Stultz wrote:
> On 06/01/2013 11:39 PM, Stephen Boyd wrote:
> > This is mostly a resend of a patch series I sent a little over a month
> > ago. I've reordered the patches so that John can pick up the first three
> > and get a generic sched_clock layer without having to take the 64 bit
> > patches. The last three patches add 64 bit support and move the architected
> > timers on ARM64 and ARM to use it.
> 
> 
> Yea, so from the initial look over it, I think I'm happy with queuing 
> the first three patches, although I'd like to get some acks from arm 
> folks on at least the first two, just so no one is surprised with it 
> going through the -tip tree.

The first two patches are pretty simple so, FWIW, you can add my ack on those:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
