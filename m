From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 Dec 2017 17:59:01 +0000
Subject: [PATCH v3 00/20] arm64: Unmap the kernel whilst running in
 userspace (KPTI)
In-Reply-To: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
Message-ID: <20171211175901.vbw7fpeijpqbp263@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 12:35:19PM +0000, Will Deacon wrote:
> Patches are also pushed here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kpti
> 
> Feedback and testing welcome. At this point, I'd like to start thinking
> about getting this merged for 4.16.

For the record, the fixed up version was pushed by Will here:

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git kpti

and I queued it for 4.16 in the arm64 for-next/core branch (same tree as
above).

-- 
Catalin
