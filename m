From: sumit.semwal@ti.com (Semwal, Sumit)
Date: Fri, 23 Dec 2011 15:30:18 +0530
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <201112211727.17104.arnd@arndb.de>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <CAF6AEGtOjO6Z6yfHz-ZGz3+NuEMH2M-8=20U6+-xt-gv9XtzaQ@mail.gmail.com>
 <20111220171437.GC3883@phenom.ffwll.local> <201112211727.17104.arnd@arndb.de>
Message-ID: <CAB2ybb_XcwLd8fx+vvditt+MUq2L2+WmsUpxH-gBKsbrVk7jGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 10:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 20 December 2011, Daniel Vetter wrote:
>> > I'm thinking for a first version, we can get enough mileage out of it by saying:
>> > 1) only exporter can mmap to userspace
>> > 2) only importers that do not need CPU access to buffer..

Thanks Rob - and the exporter can do the mmap outside of dma-buf
usage, right? I mean, we don't need to provide an mmap to dma_buf()
and restrict it to exporter, when the exporter has more 'control' of
the buffer anyways.
>
BR,
~Sumit.
