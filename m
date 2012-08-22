From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Aug 2012 10:57:20 -0700
Subject: [PATCH 1/4] ARM: export read_current_timer
In-Reply-To: <20120822174945.GS9093@mudshark.cambridge.arm.com>
References: <1345645780-2749-1-git-send-email-arnd@arndb.de>
 <1345645780-2749-2-git-send-email-arnd@arndb.de>
 <503513A2.1030002@codeaurora.org>
 <20120822174945.GS9093@mudshark.cambridge.arm.com>
Message-ID: <50351D80.6010600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/12 10:49, Will Deacon wrote:
> On the topic of the timer stuff: Shinya/Stephen, did you have a chance to
> look at the registration stuff that was proposed? I'm happy to push it if
> people will actually use it.

Yes I have tested it on our internal trees and it looks good. I plan to
send a patch to move MSM's timers over to it later this week so that we
have at least two users upstream.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
