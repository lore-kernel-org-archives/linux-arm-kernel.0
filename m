From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 9 Feb 2016 11:55:56 +0000
Subject: [PATCH 0/4] copy_page improvements
In-Reply-To: <1454417186-21828-1-git-send-email-will.deacon@arm.com>
References: <1454417186-21828-1-git-send-email-will.deacon@arm.com>
Message-ID: <20160209115556.GD16122@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 12:46:22PM +0000, Will Deacon wrote:
> Andrew Pinski (1):
>   arm64: lib: patch in prfm for copy_page if requested
> 
> Will Deacon (3):
>   arm64: prefetch: don't provide spin_lock_prefetch with LSE
>   arm64: prefetch: add alternative pattern for CPUs without a prefetcher
>   arm64: lib: improve copy_page to deal with 128 bytes at a time

Patches queued for 4.6. Thanks.

-- 
Catalin
