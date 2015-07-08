From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Jul 2015 14:51:24 +0100
Subject: [PATCH] arm64: lib: use pair accessors for copy_*_user routines
In-Reply-To: <1436293295-4353-1-git-send-email-will.deacon@arm.com>
References: <1436293295-4353-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150708135123.GD6944@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 07:21:35PM +0100, Will Deacon wrote:
> The AArch64 instruction set contains load/store pair memory accessors,
> so use these in our copy_*_user routines to transfer 16 bytes per
> iteration.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

It makes sense.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
