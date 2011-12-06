From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 6 Dec 2011 16:18:15 +0000
Subject: [GIT PULL] ARM: amba: Enable module alias autogeneration for
 AMBA drivers
In-Reply-To: <20111206155911.GA11902@mail.gnudd.com>
References: <20111206151541.GA13774@linaro.org>
 <1321961573-4562-1-git-send-email-dave.martin@linaro.org>
 <20111206155911.GA11902@mail.gnudd.com>
Message-ID: <20111206161815.GD13769@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 04:59:11PM +0100, Alessandro Rubini wrote:
> > ... it looks like Alessandro's proposed change to tidy up scripts/mod/
> > ile2alias.c may get merged soon
> 
> No, I don't think it will happen. Rusty disagrees, and his own
> suggestion is in the queue. I'm waiting a while to understand
> what is happening.
> 
> Anyways, I think it's better for me to wait for amba to come in, and
> work on scripts/mod later on. After all, it's meant to ease adding new
> buses later, not to make it more difficult for already scheduled ones.

OK -- thanks for the clarification.


Russell, it sounds like you shouldn't get a merge conflict with the
original version of the series after all.

For reference, the original pull request is here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073619.html


Cheers
---Dave
