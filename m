From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Feb 2012 11:00:40 +0000
Subject: Query: Multiple Mappings to Mem and ARMV6+
In-Reply-To: <CAOh2x=m_XWmHzm+KZX-E+P9b26=Bz9Ou76vCaSrHaTz-7xqHxA@mail.gmail.com>
References: <CAOh2x=nT365ixeHKsV7-313ZbKMoVLj0bEr9BvKB7jdGSnMV8w@mail.gmail.com>
 <20120216171520.GA9151@arm.com>
 <CAOh2x=nUPb-CcyJBmZ2wv=tsNzi=r3F16NynsbChXD=q5hSGiw@mail.gmail.com>
 <20120216174813.GE9151@arm.com>
 <CAOh2x=m_XWmHzm+KZX-E+P9b26=Bz9Ou76vCaSrHaTz-7xqHxA@mail.gmail.com>
Message-ID: <CAHkRjk7sv6iHwhpOm1ZEH3eXppG75d8r2Y=D70SrtikyrjySwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 February 2012 18:14, viresh kumar <viresh.linux@gmail.com> wrote:
> On Thu, Feb 16, 2012 at 9:48 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>> The DMA API implementation on ARM takes care of the cache cleaning and
>> invalidating.
>
> I believe that this is the reason why we have cache re-invalidation
> (we invalidated
> it in dma_map_*() earlier) in dma_unmap_*() calls for ARMv6+ for
> DMA_FROM_DEVICE.
> Am i Correct?

Yes.

-- 
Catalin
