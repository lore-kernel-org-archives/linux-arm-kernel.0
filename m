From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Mar 2018 12:16:41 +0000
Subject: [PATCH] kasan, arm64: clean up KASAN_SHADOW_SCALE_SHIFT usage
In-Reply-To: <44281e784702443f06edb837ec672984783a9621.1519923749.git.andreyknvl@google.com>
References: <44281e784702443f06edb837ec672984783a9621.1519923749.git.andreyknvl@google.com>
Message-ID: <20180305121641.GD8571@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 06:07:12PM +0100, Andrey Konovalov wrote:
> This is a follow up patch to the series I sent recently that cleans up
> KASAN_SHADOW_SCALE_SHIFT usage (which value was hardcoded and scattered
> all over the code). This fixes the one place that I forgot to fix.
> 
> The change is purely aesthetical, instead of hardcoding the value for
> KASAN_SHADOW_SCALE_SHIFT in arch/arm64/Makefile, an appropriate variable
> is declared and used.

Cheers, I'll pick this up.

Will
