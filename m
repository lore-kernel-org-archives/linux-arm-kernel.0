From: josh.cartwright@ni.com (Josh Cartwright)
Date: Mon, 29 Oct 2012 07:36:09 -0600
Subject: [PATCH v4 0/5] zynq subarch cleanups
In-Reply-To: <5c2911d7-f753-4d9f-b8d8-3bf011d58e52@TX2EHSMHS014.ehs.local>
References: <cover.1351466765.git.josh.cartwright@ni.com>
 <5c2911d7-f753-4d9f-b8d8-3bf011d58e52@TX2EHSMHS014.ehs.local>
Message-ID: <20121029133609.GE5190@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 07:24:16AM +0000, Michal Simek wrote:
> Hi Josh,
>
> > Michal-
> >
> > Here is a v5 of the zynq cleanup patchset that addresses your
> > feedback.  I've intentionally left patches 4 and 5 in the set until
> > we figure out the appropriate way to get them in tree (feel free to
> > just apply 1-3)
>
> I am ok to pick just several patches from your patchset. But this is
> no definitely good working style. Not expert for submission process
> but I think that if there is one broken patch maintainer shouldn't
> apply it.  Can someone else check this?

It turns out that with the change to patch 5 to map the uart to a known
working address (instead of VMALLOC_END - 0x1000), patch 4 isn't needed,
and as such can be dropped.  (I didn't realize this until this morning
until I had saw you had applied 1-3,5 to your tree, but not 4).

So, for what it's worth, you've applied all of the relevant patches for
this patchset.

  Josh
