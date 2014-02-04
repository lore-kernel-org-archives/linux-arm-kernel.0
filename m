From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Feb 2014 18:28:00 +0000
Subject: [PATCH 2/2] arm64: vdso: update wtm fields for
 CLOCK_MONOTONIC_COARSE
In-Reply-To: <1391456932-17815-3-git-send-email-nathan_lynch@mentor.com>
References: <1391456932-17815-1-git-send-email-nathan_lynch@mentor.com>
 <1391456932-17815-3-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140204182759.GJ664@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 07:48:52PM +0000, Nathan Lynch wrote:
> Update wall-to-monotonic fields in the VDSO data page
> unconditionally.  These are used to service CLOCK_MONOTONIC_COARSE,
> which is not guarded by use_syscall.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
