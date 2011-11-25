From: airlied@gmail.com (Dave Airlie)
Date: Fri, 25 Nov 2011 16:28:50 +0000
Subject: [Linaro-mm-sig] [RFC 1/2] dma-buf: Introduce dma buffer sharing
 mechanism
In-Reply-To: <CAPM=9tzjO7poyz_uYFFgONxzuTB86kKej8f2XBDHLGdUPZHvjg@mail.gmail.com>
References: <1318325033-32688-1-git-send-email-sumit.semwal@ti.com>
 <1318325033-32688-2-git-send-email-sumit.semwal@ti.com>
 <CAPM=9tzjO7poyz_uYFFgONxzuTB86kKej8f2XBDHLGdUPZHvjg@mail.gmail.com>
Message-ID: <CAPM=9txtWiQuF+jNZXDogCMy+nsM=00Bv3uxAiu5oKnn-KxjAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've rebuilt my PRIME interface on top of dmabuf to see how it would work,

I've got primed gears running again on top, but I expect all my object
lifetime and memory ownership rules need fixing up (i.e. leaks like a
sieve).

http://cgit.freedesktop.org/~airlied/linux/log/?h=drm-prime-dmabuf

has the i915/nouveau patches for the kernel to produce the prime interface.

Dave.
