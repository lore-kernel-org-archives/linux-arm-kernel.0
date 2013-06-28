From: olof@lixom.net (Olof Johansson)
Date: Thu, 27 Jun 2013 17:08:53 -0700
Subject: [GIT PULL] Remove ARM local timer API
In-Reply-To: <20130625200211.GA11625@codeaurora.org>
References: <20130625200211.GA11625@codeaurora.org>
Message-ID: <20130628000853.GB11547@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 01:02:12PM -0700, Stephen Boyd wrote:
> Olof/Arnd,
> 
> These patches remove the ARM local timer API. The ARM architected
> timers have already moved away from this API so this series
> migrates the rest of the users allowing us to remove the API
> entirely. Thomas has been kind enough to take the first two
> patches into timers/core in the tip tree (thanks Thomas!) so I've
> merged that into v3.10-rc1 and then applied the rest of the
> patches on top. Let me know if this is acceptable.

We need guarantees from Thomas that the branch is stable and will never be
rebased before it hit Linus tree, or we'll be in a world of pain for
dependencies like these.

Thomas, is this branch stable or do you anticipate a rebase?


-Olof
