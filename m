From: rudici.cazeao@litepoint.com (Rudici Cazeao)
Date: Fri, 28 Apr 2017 01:50:05 +0000
Subject: Running kexec, kernel gets stuck at  "Starting new kernel"
Message-ID: <4c01c76632ec4422a0661e29e218d374@LPHQEX2013.litepoint.internal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am running kexec in consecutive loops on 4 different dual-core arm processors.  On 3 of these processors, usually, somewhere between the 500th and the 5000th lopp, the kernel gets stuck at "Starting new kernel". On the remaining processor, kexec is run over and over without running into this issue. And this appears to be pretty consistent. Any ideas?

Also, on rare occasions, the kernel gets stuck at " Uncompressing Linux... done, booting the kernel". 

The SoC is Cortex-A9 (ARMv7-A)
The kernel version is 3.0.51-rt75
