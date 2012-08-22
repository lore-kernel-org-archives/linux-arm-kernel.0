From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Aug 2012 18:58:10 +0100
Subject: [PATCH 1/4] ARM: export read_current_timer
In-Reply-To: <50351D80.6010600@codeaurora.org>
References: <1345645780-2749-1-git-send-email-arnd@arndb.de>
 <1345645780-2749-2-git-send-email-arnd@arndb.de>
 <503513A2.1030002@codeaurora.org>
 <20120822174945.GS9093@mudshark.cambridge.arm.com>
 <50351D80.6010600@codeaurora.org>
Message-ID: <20120822175810.GT9093@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 06:57:20PM +0100, Stephen Boyd wrote:
> On 08/22/12 10:49, Will Deacon wrote:
> > On the topic of the timer stuff: Shinya/Stephen, did you have a chance to
> > look at the registration stuff that was proposed? I'm happy to push it if
> > people will actually use it.
> 
> Yes I have tested it on our internal trees and it looks good. I plan to
> send a patch to move MSM's timers over to it later this week so that we
> have at least two users upstream.

Awesome, I'll dust that series off at -rc3 then.

Will
