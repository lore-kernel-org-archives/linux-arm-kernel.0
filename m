From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 4 Nov 2014 09:45:42 +0800
Subject: [RFC V6 3/3] arm64:add bitrev.h file to support rbit instruction
In-Reply-To: <20141103095051.GA23019@arm.com>
References: <35FD53F367049845BC99AC72306C23D103E010D18265@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18266@CNBJMBX05.corpusers.net>
 <20141030120127.GC32589@arm.com>
 <CAKv+Gu9g5Q6fjPUy+P8YxkeDrH+bdO4kKGnxTQZRFhQpgPxaPA@mail.gmail.com>
 <20141030135749.GE32589@arm.com>
 <35FD53F367049845BC99AC72306C23D103E010D18272@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18274@CNBJMBX05.corpusers.net>
 <20141031104305.GC6731@arm.com>
 <35FD53F367049845BC99AC72306C23D103E010D18287@CNBJMBX05.corpusers.net>
 <CAKv+Gu-+fe9Hj-uGQHq8KR_6WjrQL-1q=xVBSXVXg2EJO=MW2w@mail.gmail.com>
 <20141103095051.GA23019@arm.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103E010D18288@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Will Deacon [mailto:will.deacon at arm.com]
> >
> > If this is the case, I suggest you update patch 8187/1 to retain the
> > byte_rev_table symbol, even in the accelerated case, and remove it
> > with a followup patch once Joe's patches have landed upstream. Also, a
> > link to the patches would be nice, and perhaps a bit of explanation
> > how/when they are expected to be merged.
> 
> Indeed, or instead put together a series with the appropriate acks so
> somebody can merge it all in one go. Merging this on a piecemeal basis is
> going to cause breakages (as you pointed out).
> 
> Will

Hi  Will,
Could I add you as ack-by , and submit these 2 patches into the
Patch system ?
So you can merge them together .

Thanks
