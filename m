From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 16 Feb 2012 10:14:18 -0800
Subject: Query: Multiple Mappings to Mem and ARMV6+
In-Reply-To: <20120216174813.GE9151@arm.com>
References: <CAOh2x=nT365ixeHKsV7-313ZbKMoVLj0bEr9BvKB7jdGSnMV8w@mail.gmail.com>
 <20120216171520.GA9151@arm.com>
 <CAOh2x=nUPb-CcyJBmZ2wv=tsNzi=r3F16NynsbChXD=q5hSGiw@mail.gmail.com>
 <20120216174813.GE9151@arm.com>
Message-ID: <CAOh2x=m_XWmHzm+KZX-E+P9b26=Bz9Ou76vCaSrHaTz-7xqHxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 9:48 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> The DMA API implementation on ARM takes care of the cache cleaning and
> invalidating.
>

I believe that this is the reason why we have cache re-invalidation
(we invalidated
it in dma_map_*() earlier) in dma_unmap_*() calls for ARMv6+ for
DMA_FROM_DEVICE.
Am i Correct?

> BTW, I would say cache evictions rather than speculative writes as the
> latter is something else and ARM processors don't do it (only
> speculative reads).

Oops!! Sorry for the wrong words :(

--
viresh
