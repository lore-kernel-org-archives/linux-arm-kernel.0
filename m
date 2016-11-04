From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Nov 2016 11:49:51 -0600
Subject: [PATCH V3 0/6] ARM64: Uprobe support added
In-Reply-To: <cover.1478068479.git.panand@redhat.com>
References: <cover.1478068479.git.panand@redhat.com>
Message-ID: <20161104174951.vj4il3xkdy7a2ln7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 02:40:40PM +0530, Pratyush Anand wrote:
> Pratyush Anand (6):
>   arm64: kprobe: protect/rename few definitions to be reused by uprobe
>   arm64: kgdb_step_brk_fn: ignore other's exception
>   arm64: Handle TRAP_TRACE for user mode as well
>   arm64: Handle TRAP_BRKPT for user mode as well
>   arm64: introduce mm context flag to keep 32 bit task information
>   arm64: Add uprobe support

I queued the patches for 4.10. I will push them into -next sometime next
week once I do some testing (I'm currently at the LPC).

Thanks.

-- 
Catalin
