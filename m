From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Dec 2015 11:29:27 +0000
Subject: [PATCH v4 01/13] mm/memblock: add MEMBLOCK_NOMAP attribute to
 memblock memory table
In-Reply-To: <20151208142341.b91ab5728f244a68231e3b87@linux-foundation.org>
References: <1448886507-3216-1-git-send-email-ard.biesheuvel@linaro.org>
 <1448886507-3216-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9oboT_Lk8heJWRcM=oxRW=EWioVCvZLH7N0YCkfU5tJw@mail.gmail.com>
 <20151208120743.GG19612@arm.com>
 <20151208142341.b91ab5728f244a68231e3b87@linux-foundation.org>
Message-ID: <20151209112926.GA9303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 02:23:41PM -0800, Andrew Morton wrote:
> On Tue, 8 Dec 2015 12:07:44 +0000 Will Deacon <will.deacon@arm.com> wrote:
> 
> > > I should note that this change should not affect any memblock users
> > > that never set the MEMBLOCK_NOMAP flag, but please, if you see any
> > > issues beyond 'this may conflict with other stuff we have queued for
> > > 4.5', please do let me know.
> > 
> > Indeed, I can't see that this would cause any issues, but I would really
> > like an Ack from one of the MM maintainers before taking this.
> > 
> > Please could somebody take a look?
> 
> It looks OK to me.  Please go ahead and merge it via an arm tree.

Will do, thanks Andrew.

Will
