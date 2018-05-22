From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 May 2018 18:06:32 +0100
Subject: [PATCH 1/2] arm64: make is_permission_fault() name clearer
In-Reply-To: <20180521131451.41040-2-mark.rutland@arm.com>
References: <20180521131451.41040-1-mark.rutland@arm.com>
 <20180521131451.41040-2-mark.rutland@arm.com>
Message-ID: <20180522170632.GH26955@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 02:14:50PM +0100, Mark Rutland wrote:
> The naming of is_permission_fault() makes it sound like it should return
> true for permission faults from EL0, but by design, it only does so for
> faults from EL1.
> 
> Let's make this clear by dropping el1 in the name, as we do for
> is_el1_instruction_abort().
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/fault.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
