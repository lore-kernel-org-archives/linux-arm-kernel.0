From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Fri, 29 Oct 2010 21:31:36 +0900
Subject: [RFC][PATCH 0/3] big chunk memory allocator v2
In-Reply-To: <20101029122928.GA17792@gargoyle.fritz.box>
References: <20101026190042.57f30338.kamezawa.hiroyu@jp.fujitsu.com>
	<AANLkTim4fFXQKqmFCeR8pvi0SZPXpjDqyOkbV6PYJYkR@mail.gmail.com>
	<op.vlbywq137p4s8u@pikus>
	<20101029103154.GA10823@gargoyle.fritz.box>
	<20101029195900.88559162.kamezawa.hiroyu@jp.fujitsu.com>
	<20101029122928.GA17792@gargoyle.fritz.box>
Message-ID: <20101029213136.7c4a99e2.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Oct 2010 14:29:28 +0200
Andi Kleen <andi.kleen@intel.com> wrote:

> 
> > About my patch, I may have to prealloc all required pages before start.
> > But I didn't do that at this time.
> 
> preallocate when? I thought the whole point of the large memory allocator
> was to not have to pre-allocate.
> 

Yes, one-by-one allocation prevents the allocation from sudden-attack.
I just wonder to add a knob for "migrate pages here" :)


Thanks,
-Kame
