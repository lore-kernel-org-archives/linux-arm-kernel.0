From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 8 Mar 2017 10:42:03 +0100
Subject: next build: 208 builds: 21 failed, 187 passed, 53 errors, 406
 warnings (next-20170308)
In-Reply-To: <CAK8P3a16cpvK3_a0Rxx+XqRw_d97LtVgpzcpvpzmH6U4Ty-fXQ@mail.gmail.com>
References: <58bf7d43.8173190a.8d21e.1fde@mx.google.com>
 <CAK8P3a16cpvK3_a0Rxx+XqRw_d97LtVgpzcpvpzmH6U4Ty-fXQ@mail.gmail.com>
Message-ID: <20170308094203.GA1523@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> > bmips_be_defconfig (mips) ? FAIL, 1 error, 1 warning, 0 section mismatches
> >
> > Errors:
> > arch/mips/kernel/smp-bmips.c:183:38: error: implicit declaration of function
> > 'task_stack_page' [-Werror=implicit-function-declaration]
> 
> A new regression from the end of the merge window, also present in mainline.
> I sent a fix yesterday, addressing various mips build failures.

Haven't heard from Ralf yet, so I've applied your patch to tip:core/urgent and 
will get it to Linus ASAP (i.e. later today), to minimize the size of the 
build-breakage window.

Thanks,

	Ingo
