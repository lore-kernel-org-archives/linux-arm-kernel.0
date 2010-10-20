From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 20 Oct 2010 14:01:48 +0800
Subject: [RFC, PATCH 0/5] unify definition of CLOCK_TICK_RATE across
	different platforms
In-Reply-To: <20101020045110.GW12979@mail.wantstofly.org>
References: <20101020045110.GW12979@mail.wantstofly.org>
Message-ID: <AANLkTi=WCAjAu0PGbtkXMQdX+FzXVZbwo60adhyT8sGb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 12:51 PM, Lennert Buytenhek
<buytenh@wantstofly.org> wrote:
> One of the things preventing building an ARM multiplatform kernel
> image is the fact that CLOCK_TICK_RATE (and as a consequence, LATCH)
> is defined differently for each ARM platform.
>
> The patches in this series:
> - pull the per-platform CLOCK_TICK_RATE defines from <mach/timex.h>
> ?into arch/arm/mach-foo/ (on those platforms that use the
> ?CLOCK_TICK_RATE define and/or the LATCH define in their platform
> ?support code);
> - define CLOCK_TICK_RATE as a platform-independent value in <asm/timex.h>;
> - get rid of all <mach/timex.h> include files.
>

Excellent!
