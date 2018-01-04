From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 4 Jan 2018 14:18:41 +0000
Subject: [PATCH] arm64: asid: Do not replace active_asids if already 0
In-Reply-To: <20180104114028.GA10756@arm.com>
References: <20180104111721.33834-1-catalin.marinas@arm.com>
 <20180104114028.GA10756@arm.com>
Message-ID: <20180104141841.vbtu5m24mky6ud3d@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 11:40:28AM +0000, Will Deacon wrote:
> On Thu, Jan 04, 2018 at 11:17:21AM +0000, Catalin Marinas wrote:
> > (and we now have a formally verified ASID allocator ;))
> 
> It would be cool to mention the verifier in the commit message; potentially
> even including the code somewhere so that it can be used to test future
> changes.

Good idea. I pushed it here:

https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/

(keeping the repository name generic as I may push other specs)

> Acked-by: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks.

-- 
Catalin
