From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Aug 2017 18:17:59 +0100
Subject: [PATCH] arm64: compat: Remove leftover variable declaration
In-Reply-To: <20170804171710.21736-1-salyzyn@android.com>
References: <20170804171710.21736-1-salyzyn@android.com>
Message-ID: <20170810171758.dpk2h3jcykqz7q4p@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 10:17:00AM -0700, Mark Salyzyn wrote:
> From: Kevin Brodsky <kevin.brodsky@arm.com>
> 
> Commit a1d5ebaf8ccd ("arm64: big-endian: don't treat code as data when
> copying sigret code") moved the 32-bit sigreturn trampoline code from
> the aarch32_sigret_code array to kuser32.S. The commit removed the
> array definition from signal32.c, but not its declaration in
> signal32.h. Remove the leftover declaration.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>

Applied. Thanks.

-- 
Catalin
