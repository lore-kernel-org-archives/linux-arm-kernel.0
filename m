From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Mar 2011 11:17:19 +0100
Subject: Booting Integrator/AP with ARM920T
Message-ID: <AANLkTi=ko-8B=C32e42HsL7vOZa63t_JtmfGKqYht99P@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have this Integrator/AP development board here in my office:

Initialising Boot Monitor System Information Block
boot Monitor > i
ARM bootPROM [Version 1.3] Rebuilt on Jun 26 2001 at 22:04:10
Running on a Integrator Evaluation Board
Board Revision V1.0, ARM920T Processor
Memory Size is 128MBytes, Flash Size is 32MBytes
Copyright (c) ARM Limited 1999 - 2001. All rights reserved.
Board designed by ARM Limited
Hardware support provided at http://www.arm.com/
For help on the available commands type ? or h
boot Monitor >

Does anyone beside me *ever* try to actually boot a recent kernel
on this thing?

How do you do it? Do I need patched U-boots etc, or can I just load
a Z-record image of vmlinux into RAM over the serial console?

Needless to say, ARM Ltd. has deleted the web pages for official
support of this thing as far as I can see. I was going to try out a
few patches affecting mach-integrator...

Yours,
Linus Walleij
