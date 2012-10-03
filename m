From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 3 Oct 2012 09:39:30 -0400
Subject: [PATCH] [ARM] Build failure CONFIG_ARCH_KIRKWOOD_DT relies on
 CACHE_FEROCEON_L2
In-Reply-To: <20121002175002.GD23733@obsidianresearch.com>
References: <20120930232253.GD30637@obsidianresearch.com>
 <CAOesGMgpDs60jGsV4Wu-A7M+ThXh7YVkgb_mPgMJfPwNa_QbSw@mail.gmail.com>
 <20121001044337.GA8446@obsidianresearch.com>
 <CAOesGMhQpqdCRoV85vW+7THstbx+HWmCkR3Q6bpK6uLEmhKqfw@mail.gmail.com>
 <20121002175002.GD23733@obsidianresearch.com>
Message-ID: <20121003133930.GP17765@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 11:50:02AM -0600, Jason Gunthorpe wrote:
> On Mon, Oct 01, 2012 at 07:31:58AM -0700, Olof Johansson wrote:
> 
> > Ah. diff took out the #else in the middle and I didn't look at the
> > file. Obviously correct as-is.
> > 
> > In some other places we choose to put the ifdef outside the function
> > and provide a static inline stub in the header file instead. Either
> > way works fine though.
> 
> I don't actually expect anyone will run CONFIG_ARCH_KIRKWOOD_DT
> without CACHE_FEROCEON_L2 - I had thought about just forcing kconfig
> to include CACHE_FEROCEON_L2, but figured there was some reason they
> were separate.. 
> 
> Is there anything further I should do to get this patch upstream?

nope, it's in the queue.

thx,

Jason.
