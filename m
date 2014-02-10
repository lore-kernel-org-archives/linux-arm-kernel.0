From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Feb 2014 16:18:18 +0000
Subject: [PATCH v2 1/5] arm64: barriers: make use of barrier options
 with explicit barriers
In-Reply-To: <1392042159-11603-1-git-send-email-will.deacon@arm.com>
References: <1392042159-11603-1-git-send-email-will.deacon@arm.com>
Message-ID: <20140210161818.GJ25305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 02:22:35PM +0000, Will Deacon wrote:
> When calling our low-level barrier macros directly, we can often suffice
> with more relaxed behaviour than the default "all accesses, full system"
> option.
> 
> This patch updates the users of dsb() to specify the option which they
> actually require.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
