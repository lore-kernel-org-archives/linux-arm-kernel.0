From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 15 Oct 2013 15:27:42 +0200
Subject: [PATCH 0/2] Revert support for reserved memory regions defined in
 device tree
In-Reply-To: <20131015114035.6CA5FC40098@trevor.secretlab.ca>
References: <1381476448-14548-1-git-send-email-m.szyprowski@samsung.com>
 <20131015114035.6CA5FC40098@trevor.secretlab.ca>
Message-ID: <525D42CE.5010008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2013-10-15 13:40, Grant Likely wrote:
> On Fri, 11 Oct 2013 09:27:26 +0200, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > Hi all!
> >
> > Benjamin Herrenschmidt pointed a few issues in the proposed design of
> > device tree bindings for contiguous memory allocator and reserved memory
> > regions:
> > https://lkml.org/lkml/2013/9/15/151
> > http://www.spinics.net/lists/arm-kernel/msg273548.html
> >
> > Some time has passed, but there is still no consensus on the bindings
> > for the reserved memory and various drawback of this solution has been
> > shown, so in my opinion the best I can do now is to revert them
> > completely and start from scratch again later.
>
> I had some fixup patches that I was getting ready to post, but your
> right. We're really late to be doing anything like that. I've applied
> the reverts and we'll plan on hammering something out in Edinburgh next
> week so that it can be merged for v3.13

Sadly I won't be able to go to Edinburgh because of other business trip 
the same time. However Tomasz Figa will be there for the whole week, he 
will also attend DT-summit, so I hope that you will manage to find a 
consensus. I will implement whatever you will agree then.

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
