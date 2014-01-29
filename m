From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Jan 2014 10:57:22 +0000
Subject: [PATCH v3] ARM: hw_breakpoint: Add ARMv8 support
In-Reply-To: <1390935112-28465-1-git-send-email-cov@codeaurora.org>
References: <20140128183851.GK2885@mudshark.cambridge.arm.com>
 <1390935112-28465-1-git-send-email-cov@codeaurora.org>
Message-ID: <20140129105722.GD26622@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On Tue, Jan 28, 2014 at 06:51:51PM +0000, Christopher Covington wrote:
> Add the trivial support necessary to get hardware breakpoints
> working for GDB on ARMv8 simulators running in AArch32 mode.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
> 
>  v3: assume for now that ARMv9 and later will update FSR

Please can you stick this into the patch system? I don't have any other
hw_breakpoint changes queued, so I doubt I'll send a pull for 3.15.

Cheers,

Will
