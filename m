From: amit.shah@redhat.com (Amit Shah)
Date: Wed, 15 May 2013 11:00:32 +0530
Subject: [PATCH V2 2/3] Documentation: virtio: Add emergency write
 (emerg_wr) config register in virtio console.
In-Reply-To: <87hai427di.fsf@rustcorp.com.au>
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
 <1367842791-30285-3-git-send-email-pranavkumar@linaro.org>
 <8761yn382w.fsf@rustcorp.com.au>
 <CAAHg+Hi6BHqwOznnC9qxkc5pBWz7r5qpz9Nhh=EeNenhjhHohg@mail.gmail.com>
 <87hai427di.fsf@rustcorp.com.au>
Message-ID: <20130515053032.GA32133@amit.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (Wed) 15 May 2013 [13:59:29], Rusty Russell wrote:
> Pranavkumar Sawargaonkar <pranavkumar@linaro.org> writes:
> > Hi Rusty,
> >
> > On 13 May 2013 08:22, Rusty Russell <rusty@rustcorp.com.au> wrote:
> >> Pranavkumar Sawargaonkar <pranavkumar@linaro.org> writes:
> >>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> >>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> >>> ---
> >>>  Documentation/virtual/virtio-spec.txt |    8 +++++++-
> >>>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> OK, I applied this to the lyx master, with three changes:
> >> 1) Changed "filed" to "field".
> >> 2) Added ", or even acknowledging the feature" after "without
> >>    initializing virtio queues".
> >> 3) Added an initial point to the Device Initialization section:
> >>
> >>    1. If the VIRTIO_CONSOLE_F_EMERG_WRITE feature is offered, the
> >>    emerg_wr field of the configuration can be written at any time. Thus
> >>    it should work for very early boot debugging output as well as
> >>    catastophic OS failures (eg. virtio ring corruption).
> >
> > Thanks for applying this patch.
> > Have you also applied first patch ([PATCH V2 1/3] virtio: console: Add
> > emergency writeonly register to config space)
> > with this?  (https://lkml.org/lkml/2013/5/6/169)
> 
> Would like Amit's Ack, since he's de-facto console maintainer.

I've been away, and am reviewing the discussions here.  Expect a
response later today.

Thanks,

		Amit
