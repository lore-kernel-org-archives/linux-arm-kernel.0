From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Mar 2017 19:29:42 +0100
Subject: [PATCH] arm64: drop non-existing vdso-offsets.h from .gitignore
In-Reply-To: <1490895857-26856-1-git-send-email-yamada.masahiro@socionext.com>
References: <1490895857-26856-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170330182941.GB16364@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 02:44:17AM +0900, Masahiro Yamada wrote:
> Since commit a66649dab350 ("arm64: fix vdso-offsets.h dependency"),
> include/generated/vdso-offsets.h is directly generated without
> arch/arm64/kernel/vdso/vdso-offsets.h.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm64/kernel/vdso/.gitignore | 1 -
>  1 file changed, 1 deletion(-)

Thanks, queued as a fix.

Will
