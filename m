From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Feb 2014 11:51:12 +0000
Subject: ARM64: Not all h/w events are mapped in perf_event.c
In-Reply-To: <CAFpQJXXD1f=PvUTtRKaRRK-ADU=HaUr2QmTG=by3vP=2eYhAkw@mail.gmail.com>
References: <CAFpQJXXD1f=PvUTtRKaRRK-ADU=HaUr2QmTG=by3vP=2eYhAkw@mail.gmail.com>
Message-ID: <20140227115112.GD30003@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 11:39:20AM +0000, Ganapatrao Kulkarni wrote:
> Hi Will,

Hello,

> All h/w perf events are not mapped in arch/arm64/kernel/perf_event.c
> (many are set to HW_OP_UNSUPPORTED/CACHE_OP_UNSUPPORTED)
> 
> any specific reason for not mapping?

Can you be more specific please? IIRC, we currently map only the architected
events, as opposed to CPU-specific events, which I'm happy to add separately
(like we do for arch/arm/).

Will
