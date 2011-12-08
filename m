From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 8 Dec 2011 09:50:59 +0200
Subject: [PATCH 0/7] Introducing a generic AMP framework
In-Reply-To: <CAK=WgbYVscyeJ5Og5iPx-tjEApa2KgAR1bnZiZUUcv0HxBEtOw@mail.gmail.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <874nywpfkd.fsf@rustcorp.com.au>
 <CAK=WgbaF=yvGXvJdENrMoi4wWxaQa3UpbtsRm3mcA3cFdDCitA@mail.gmail.com>
 <87obw31v31.fsf@rustcorp.com.au>
 <CAK=WgbYVscyeJ5Og5iPx-tjEApa2KgAR1bnZiZUUcv0HxBEtOw@mail.gmail.com>
Message-ID: <CAK=WgbbmZR5gPqD-0Dc2jWom9J_z+iV0+nAB-BAFedbTqXk0Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rusty,

On Wed, Nov 23, 2011 at 11:58 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Wed, Nov 23, 2011 at 3:33 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> That would imply that I'd done more than glance over them, and
>> unfortunately I haven't :(
>
> Np, thanks for glancing :)

I'd still like to ask for your Ack at least for the virtio_ids.h
change (please see below, and for the full patch, see
http://www.spinics.net/lists/linux-omap/msg59537.html):

Anyone following our threads will know you approved it, but I'm still
technically required to have your explicit ack as long as the patch
isn't going through your tree.

I can always add something like:

Virtio_ids.h-change-acked-by: Rusty Russell <rusty@rustcorp.com.au>

So it doesn't imply anything else but this specific change, or I can
just put that hunk in a separate patch, and add then add your Acked-by
(so it doesn't imply anything on the rest of the patch set).

Does that sound reasonable to you ?

Thanks,
Ohad.

diff --git a/include/linux/virtio_ids.h b/include/linux/virtio_ids.h
index 85bb0bb..b37c521 100644
--- a/include/linux/virtio_ids.h
+++ b/include/linux/virtio_ids.h
@@ -34,6 +34,7 @@
 #define VIRTIO_ID_CONSOLE      3 /* virtio console */
 #define VIRTIO_ID_RNG          4 /* virtio ring */
 #define VIRTIO_ID_BALLOON      5 /* virtio balloon */
+#define VIRTIO_ID_RPMSG                7 /* virtio remote processor messaging *
 #define VIRTIO_ID_9P           9 /* 9p virtio console */

 #endif /* _LINUX_VIRTIO_IDS_H */
