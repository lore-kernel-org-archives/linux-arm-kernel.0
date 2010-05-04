From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 4 May 2010 22:54:21 +0800
Subject: build error of v2.6.34-rc6
Message-ID: <s2zf17812d71005040754o91791292vf137741a3c7956e2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seems to be a regression introduced since v2.6.34-rc5, the latter I was
able to build without the error below:

/home/ycmiao/linux-2.6/arch/arm/kernel/entry-armv.S: Assembler messages:
/home/ycmiao/linux-2.6/arch/arm/kernel/entry-armv.S:442: Error: symbol
ret_from_exception is in a different section
/home/ycmiao/linux-2.6/arch/arm/kernel/entry-armv.S:490: Error: symbol
ret_from_exception is in a different section
/home/ycmiao/linux-2.6/arch/arm/kernel/entry-armv.S:491: Error: symbol
__und_usr_unknown is in a different section
make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1
make[2]: *** Waiting for unfinished jobs....
