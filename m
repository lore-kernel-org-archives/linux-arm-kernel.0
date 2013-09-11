From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Sep 2013 11:59:29 +0100
Subject: [PATCH 2/5] ARM64: Move some signal code to a seperate file to
 be reused by ILP32.
In-Reply-To: <1378762380-13152-2-git-send-email-apinski@cavium.com>
References: <1378762380-13152-1-git-send-email-apinski@cavium.com>
 <1378762380-13152-2-git-send-email-apinski@cavium.com>
Message-ID: <20130911105929.GC26777@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 09, 2013 at 10:32:56PM +0100, Andrew Pinski wrote:
> Since the ILP32 ABI uses similar signal code as the LP64 ABI, it makes sense to reuse rather
> than copy the same code.

At a first look, I don't really like this part. I'll comment more on the
last patch.

-- 
Catalin
