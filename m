From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 15 Sep 2011 09:42:05 +0930
Subject: [RFC 7/8] drivers: introduce rpmsg,
	a remote-processor messaging bus
In-Reply-To: <CAK=WgbY0zMkHw9XHDKPEfVQZVRfGP=nMmyJgm6jD5FEkBZkMRQ@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-8-git-send-email-ohad@wizery.com>
	<87liwu8u3q.fsf@rustcorp.com.au>
	<BANLkTi=7TBMqnEf2qustrmSaubtTam79Bw@mail.gmail.com>
	<CAK=WgbY0zMkHw9XHDKPEfVQZVRfGP=nMmyJgm6jD5FEkBZkMRQ@mail.gmail.com>
Message-ID: <87d3f2hdey.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Sep 2011 21:38:43 +0300, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Rusty,
> 
> On Wed, Jun 22, 2011 at 1:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > On Wed, Jun 22, 2011 at 5:42 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> >> On Tue, 21 Jun 2011 10:18:33 +0300, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> >>> +#define VIRTIO_ID_RPMSG ? ? ? ? ? ? ?10 /* virtio remote processor messaging */
> >>
> >> I think you want 6. ?Plan 9 jumped ahead to grab 9 :)
> >
> > 6 it is :)
> 
> Looking at the virtio-spec, it seems that 6 is taken by 'ioMemory'.
> There's no indication for it in virtio_ids.h though, and the
> virtio-spec has no appendix for this id, so maybe it's available after
> all ?
> 
> If it is available, I'll take it for rpmsg, and will also update
> virtio-spec appropriately. Otherwise, we'll settle on 7 ? :)

7... numbers are cheap :)

Cheers,
Rusty.
