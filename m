From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 22 Nov 2011 13:40:04 +0200
Subject: [PATCH 0/7] Introducing a generic AMP framework
In-Reply-To: <874nywpfkd.fsf@rustcorp.com.au>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <874nywpfkd.fsf@rustcorp.com.au>
Message-ID: <CAK=WgbaF=yvGXvJdENrMoi4wWxaQa3UpbtsRm3mcA3cFdDCitA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2011 at 6:00 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Tue, 25 Oct 2011 11:48:19 +0200, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Modern SoCs typically employ a central symmetric multiprocessing (SMP)
>> application processor running Linux, with several other asymmetric
>> multiprocessing (AMP) heterogeneous processors running different instances
>> of operating system, whether Linux or any other flavor of real-time OS.
>
> OK, I'm not even sure who this should go through

We shortly discussed this in ELCE, and this can either go through the
arm-soc tree or directly to Linus; however Arnd prefers really.

The previous RFC iteration was reviewed quite extensively (especially
by Grant. thanks Grant!) but I was hoping to get some more review or
feedback on this iteration as well (any form of Acked-by, Reviewed-by,
+1-by or No-way-by are welcome).

At this point I know of at least four vendors (besides TI) who are
actively looking into supporting this, and it's getting a bit hard to
collaborate, so I plan to get this into linux-next later this week
(minus the virtio-spec.txt change which I'll send directly to you,
Rusty) in the hope of getting this merged into 3.3.

>, but no objections here

Can I add your Acked-by on the virtio parts (mainly patches 3 and 6) ?

Thanks!
Ohad.
