From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 May 2017 09:25:23 +0100
Subject: [PATCH v2 0/4] arm64: improve tagged pointer handling
In-Reply-To: <1493825868-30872-1-git-send-email-kristina.martsenko@arm.com>
References: <1493825868-30872-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <20170510082523.oim7iorqa2w4vzlo@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 04:37:44PM +0100, Kristina Martsenko wrote:
> Kristina Martsenko (4):
>   arm64: traps: fix userspace cache maintenance emulation on a tagged
>     pointer
>   arm64: hw_breakpoint: fix watchpoint matching for tagged pointers
>   arm64: entry: improve data abort handling of tagged pointers
>   arm64: documentation: document tagged pointer stack constraints

Queued for 4.12. Thanks.

-- 
Catalin
