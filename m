From: tvainikk@gmail.com (Tuomas Vainikka)
Date: Fri, 08 Oct 2010 21:31:51 +0300
Subject: unrecognized/unsupported machine ID
Message-ID: <4CAF6397.50403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I compiled linux 2.6.35.7 stable release from kernel.org, loaded it to
RedBoot and got this:

EM-7210 (RAM mode) 2005-12-22
== Executing boot script in 5.000 seconds - enter ^C to abort
^C
RedBoot> load -v -r -b 0x01008000 -m tftp zImage-20101005
/
Raw file loaded 0x01008000-0x011e7187, assumed entry at 0x01008000
RedBoot> exec
Using base address 0x01008000 and length 0x001df188
Uncompressing Linux... done, booting the kernel.

Error: unrecognized/unsupported machine ID (r1 = 0x00000147).

Available machine support:

ID (hex)        NAME
000004bc        Lanner EM7210

Please check your kernel config and/or bootloader.



The machine I'm trying to execute linux on is Intel SS4000E, which
should identify as Lanner EM7210.
Linux 2.6.25.20 runs fine.

-Tuomas
