From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Oct 2015 14:19:30 +0100
Subject: [PATCHv4 0/6] arm64: perf: heterogeneous PMU support
In-Reply-To: <1443779708-26789-1-git-send-email-mark.rutland@arm.com>
References: <1443779708-26789-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20151007131930.GJ16065@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 10:55:02AM +0100, Mark Rutland wrote:
> This patch series moves the arm64 code over to the librified perf code now used
> by 32-bit arm, in the process gaining support for heterogeneous PMUs. Tailored
> support is then added for Cortex-A53 and Cortex-A57 as used in Juno systems.
> 
> With this series applied, perf can be used to monitor 64-bit systems with
> heterogeneous PMUs in an identical fashion to 32-bit systems, e.g.

For the series:

  Acked-by: Will Deacon <will.deacon@arm.com>

There's a trailing whitespace error in the first patch, but Catalin can
probably fix that up.

Will
