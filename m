From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Oct 2015 14:27:28 +0100
Subject: [PATCHv4 0/6] arm64: perf: heterogeneous PMU support
In-Reply-To: <20151007131930.GJ16065@arm.com>
References: <1443779708-26789-1-git-send-email-mark.rutland@arm.com>
 <20151007131930.GJ16065@arm.com>
Message-ID: <20151007132727.GB17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 02:19:30PM +0100, Will Deacon wrote:
> On Fri, Oct 02, 2015 at 10:55:02AM +0100, Mark Rutland wrote:
> > This patch series moves the arm64 code over to the librified perf code now used
> > by 32-bit arm, in the process gaining support for heterogeneous PMUs. Tailored
> > support is then added for Cortex-A53 and Cortex-A57 as used in Juno systems.
> > 
> > With this series applied, perf can be used to monitor 64-bit systems with
> > heterogeneous PMUs in an identical fashion to 32-bit systems, e.g.
> 
> For the series:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>

Thanks.

> There's a trailing whitespace error in the first patch, but Catalin can
> probably fix that up.

I fixed this as well. Queued.

-- 
Catalin
