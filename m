From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 May 2017 09:24:32 +0100
Subject: [PATCH 0/6] arm64: inline assembly fixes + cleanup
In-Reply-To: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
References: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170510082432.7jw5moulrp44khfg@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 04:09:32PM +0100, Mark Rutland wrote:
> Mark Rutland (6):
>   arm64: xchg: hazard against entire exchange variable
>   arm64: ensure extension of smp_store_release value
>   arm64: uaccess: ensure extension of access_ok() addr
>   arm64: armv8_deprecated: ensure extension of addr
>   arm64: atomic_lse: match asm register sizes
>   arm64: uaccess: suppress spurious clang warning

Queued for 4.12.

-- 
Catalin
