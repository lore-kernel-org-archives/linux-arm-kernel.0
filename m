From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 8 Jul 2013 08:35:29 -0700
Subject: [GIT PULL] Remove ARM local timer API
In-Reply-To: <20130628000853.GB11547@quad.lixom.net>
References: <20130625200211.GA11625@codeaurora.org>
 <20130628000853.GB11547@quad.lixom.net>
Message-ID: <20130708153528.GB830@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27, Olof Johansson wrote:
> On Tue, Jun 25, 2013 at 01:02:12PM -0700, Stephen Boyd wrote:
> > Olof/Arnd,
> > 
> > These patches remove the ARM local timer API. The ARM architected
> > timers have already moved away from this API so this series
> > migrates the rest of the users allowing us to remove the API
> > entirely. Thomas has been kind enough to take the first two
> > patches into timers/core in the tip tree (thanks Thomas!) so I've
> > merged that into v3.10-rc1 and then applied the rest of the
> > patches on top. Let me know if this is acceptable.
> 
> We need guarantees from Thomas that the branch is stable and will never be
> rebased before it hit Linus tree, or we'll be in a world of pain for
> dependencies like these.
> 
> Thomas, is this branch stable or do you anticipate a rebase?
> 

This branch has merged into Linus' tree. Can this go through the
arm-soc tree now?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
