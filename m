From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Feb 2014 21:00:48 -0500
Subject: [PATCHv2 2/2] arm: Get rid of meminfo
In-Reply-To: <1391558551-31395-3-git-send-email-lauraa@codeaurora.org>
References: <1391558551-31395-1-git-send-email-lauraa@codeaurora.org>
 <1391558551-31395-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140205020048.GL8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 04:02:31PM -0800, Laura Abbott wrote:
> memblock is now fully integrated into the kernel and is the prefered
> method for tracking memory. Rather than reinvent the wheel with
> meminfo, migrate to using memblock directly instead of meminfo as
> an intermediate.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
...
>  arch/arm/mach-orion5x/common.c           |    3 +-
>  arch/arm/mach-orion5x/common.h           |    3 +-
...

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
