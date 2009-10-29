From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 29 Oct 2009 16:01:49 +0800
Subject: Query : head.S assembler options
In-Reply-To: <d06872620910290011u6d724437s991a3de94a660e60@mail.gmail.com>
References: <d06872620910290011u6d724437s991a3de94a660e60@mail.gmail.com>
Message-ID: <f17812d70910290101s392fa8dby16a0b7d33b6814e3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That really depends on the kbuild Makefiles, where I guess -D__ASSEMBLY__
is there in KBUILD_AFLAGS, please check it out.

BTW: your name in Indic is really cool, rarely see.

2009/10/29 ????? ????? ????? <sureshkrshukla@gmail.com>:
> I want to see the assembler options for : arch/arm/kernel/head.S.
> I want to confirm if it has __ASSEMBLY__ being passed to it.
>
> Any ideas ?
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
