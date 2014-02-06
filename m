From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 11:55:27 +0000
Subject: [PATCH 5/6] arm64: barriers: wire up new barrier options
In-Reply-To: <1391686253-13436-5-git-send-email-will.deacon@arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
 <1391686253-13436-5-git-send-email-will.deacon@arm.com>
Message-ID: <20140206115526.GO29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 11:30:52AM +0000, Will Deacon wrote:
> Now that all callers of the barrier macros are updated to pass the
> mandatory options, update the macros so the option is actually used.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
