From: mmarek@suse.com (Michal Marek)
Date: Wed, 20 Apr 2016 10:29:11 +0200
Subject: [PATCH] kbuild: drop FORCE from PHONY targets
In-Reply-To: <1457828035-30584-1-git-send-email-yamada.masahiro@socionext.com>
References: <1457828035-30584-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <57173DD7.6020601@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 13.3.2016 v 01:13 Masahiro Yamada napsal(a):
> These targets are marked as PHONY.  No need to add FORCE to their
> dependency.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Makefile                     | 8 ++++----
>  arch/arm/vdso/Makefile       | 2 +-
>  arch/ia64/Makefile           | 4 ++--
>  arch/x86/entry/vdso/Makefile | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)

Applied to kbuild.git#kbuild now, sorry for the delay.

Michal
