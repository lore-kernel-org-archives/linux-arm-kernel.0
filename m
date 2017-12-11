From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 Dec 2017 10:32:30 +0000
Subject: [PATCH v8 00/20] ILP32 for ARM64
In-Reply-To: <20171116111130.f5xmomxgm234i6v7@yury-thinkpad>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
 <20171116111130.f5xmomxgm234i6v7@yury-thinkpad>
Message-ID: <20171211103230.wzg4w6eybynzh5qf@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On Thu, Nov 16, 2017 at 02:11:30PM +0300, Yury Norov wrote:
> This is ILP32 patches on top of 4.14 kernel:
> https://github.com/norov/linux/commits/ilp32-4.14
> 
> I tested the series with LTP lite built by Linaro toolchain, and no
> regressions found.

Thanks. I gave it a try as well with LTP and pushed a staging/ilp32-4.14
branch to the arm64 tree on git.kernel.org. BTW, you've added two random
patches on top of this branch (which I removed).

> By the way, do you have plans to upstream arch subseries? 
> https://lkml.org/lkml/2017/9/25/574

I was hoping Arnd would pick them up since they are rather UAPI specific
than arm64.

BTW, I wonder whether the nds32 patches actually follow the proposed
defaults in your patches like force_o_largefile() and get/setrlimit:

https://lkml.org/lkml/2017/11/27/474

(I haven't reviewed the nds32 patches in detail though)

-- 
Catalin
