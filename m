From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 16 Oct 2015 08:14:19 +0100
Subject: [PATCH v4 0/5] Mailbox: Provide support STi based platforms
In-Reply-To: <CAJe_ZhcBwSxOAwssztipQtYzG8mPQ4Wmu+=h47gT3vc4gv7mJg@mail.gmail.com>
References: <1444050140-24733-1-git-send-email-lee.jones@linaro.org>
 <CAJe_ZhcBwSxOAwssztipQtYzG8mPQ4Wmu+=h47gT3vc4gv7mJg@mail.gmail.com>
Message-ID: <20151016071419.GC31804@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Oct 2015, Jassi Brar wrote:

> On 5 October 2015 at 18:32, Lee Jones <lee.jones@linaro.org> wrote:
> > Hi Jassi,
> >
> > This should be it.  Exciting times!
> >
> > ST's platforms currently support a maximum of 5 Mailboxes, one for
> > each of the supported co-processors situated on the platform.  Each
> > Mailbox is divided up into 4 instances which consist of 32 channels.
> > Messages are passed between the application and co-processors using
> > shared memory areas.
> >
> > Also included in the set is an example Client which should be generic
> > enough to use as a testing environment for all Mailbox IPs which use
> > shared memory or the API to pass messages.  With small changes, it
> > should also be able to test more extravagant implementations.
> >
> > v3 -> v4:
> >  - More protection in MBOX_BASE() MACRO
> >  - Remove unused tx-only marker
> >
> Are you sure about the tx-only marker? :)
> 
> Since it is also a DT property, I think we should have it removed
> before we apply the patchset. Lets get it done today.

Wow!  I can't even explain that.  It's gone from my local repo!

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
