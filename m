From: mst@redhat.com (Michael S. Tsirkin)
Date: Tue, 29 Nov 2011 17:19:59 +0200
Subject: [RFC] virtio: use mandatory barriers for remote processor vdevs
In-Reply-To: <CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
 <20111129131110.GC19157@redhat.com>
 <CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
Message-ID: <20111129151958.GA31789@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 03:57:19PM +0200, Ohad Ben-Cohen wrote:
> > Is an extra branch faster or slower than reverting d57ed95?
> 
> Sorry, unfortunately I have no way to measure this, as I don't have
> any virtualization/x86 setup. I'm developing on ARM SoCs, where
> virtualization hardware is coming, but not here yet.

You can try using the micro-benchmark in tools/virtio/.
That does not need virtualization.

-- 
MST
