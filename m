From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 13:49:57 -0700
Subject: [RESEND PATCH] arm64: dts: add interrupt-affinity property to
 pmu node for juno
In-Reply-To: <1427709570-15891-1-git-send-email-will.deacon@arm.com>
References: <1427709570-15891-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150403204957.GD23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 10:59:30AM +0100, Will Deacon wrote:
> Make the Juno .dts robust against potential reordering of the CPU nodes
> by adding an explicit interrupt-affinity property to the PMU node. While
> we're at it, fix the PMU interrupts numbers too.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Resending, as requested. Please apply for 4.1.

Thanks, applied.


-Olof
