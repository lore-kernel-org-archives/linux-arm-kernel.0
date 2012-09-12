From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 12 Sep 2012 12:58:28 +0530
Subject: [PATCH] CPUFreq: OMAP: remove unnecessary plat/ includes
In-Reply-To: <alpine.DEB.2.00.1209120030420.9444@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209120030420.9444@utopia.booyaka.com>
Message-ID: <CAMQu2gz4mcxqq=EFJzseXcgS_XxzDWGTP1sC5-FbkbxszUiwcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 6:02 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Remove some unnecessary plat/ includes that are interfering with multi-subarch
> ARM kernels.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Kevin Hilman <khilman@ti.com>
> ---
>
> Still awaiting some final testing here.  Rafael, was wondering if you
> would be willing to ack this so we can merge it via the OMAP tree?
> Otherwise the patch can be split into an OMAP part and a CPUFreq part that
> can go in across two merge windows.
>
Hmm.
I did similar change[1] a while back. Kevin didn't like idea though
that point of time.

Regards,
Santosh

[1] http://www.spinics.net/lists/linux-omap/msg48382.html
