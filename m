From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Jul 2011 13:02:01 +0200
Subject: linux-next regression on ARM926
Message-ID: <CACRpkdbBrVda2oD42tjrWiG6uHXAdWwpr6cZ7qnSc2KM82XCfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

do you have any hints on how to resolve this build error in the -next
tree:

  LD      .tmp_vmlinux1
arch/arm/mm/built-in.o:(.init.data+0xe0): undefined reference to
`cpu_arm926_do_suspend'
arch/arm/mm/built-in.o:(.init.data+0xe4): undefined reference to
`cpu_arm926_do_resume'
make[2]: *** [.tmp_vmlinux1] Error 1
make[1]: *** [sub-make] Error 2
make[1]: Leaving directory `/home/linus/linux-next'
make: *** [build] Error 2

This is while building the U300, I can't really tell if the error is on my
(U300) side or in the recent patches to the proc_arm926 stuff?
It seems all ARM926 SoCs were affected.

Thanks,
Linus Walleij
