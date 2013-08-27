From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 Aug 2013 17:41:21 -0400
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <20130827210248.GA19625@obsidianresearch.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost> <521D063F.4040404@gmail.com>
 <20130827210248.GA19625@obsidianresearch.com>
Message-ID: <20130827214121.GI19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 03:02:48PM -0600, Jason Gunthorpe wrote:
> Since this is so complex, maybe it is OK to abandon support for non-DT
> boards in the WDT driver? Watchdog is not critical functionality, so
> nobody should be critically impacted. Boards would have to migrate
> to DT to get WDT back?

I'm not 100% opposed to this.  We need to give it careful thought, but
it may be a viable solution since we are at the "convert old boards to
DT" stage anyhow.  If we had ten more drivers and 6 release cycles in
front of us, I'd say no.

thx,

Jason.
