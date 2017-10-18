From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Oct 2017 12:10:34 +0100
Subject: [PATCH v4 08/13] arm64: Add vmap_stack header file
In-Reply-To: <20171017174432.1684-9-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171017174432.1684-9-james.morse@arm.com>
Message-ID: <20171018111033.25akkmnqsuff2wqk@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 06:44:27PM +0100, James Morse wrote:
> Today the arm64 arch code allocates an extra IRQ stack per-cpu. If we
> also have SDEI and VMAP stacks we need two extra per-cpu VMAP stacks.
> 
> Move the VMAP stack allocation out to a helper in a new header file.
> This avoids missing THREADINFO_GFP, or getting the all-important alignment
> wrong.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
