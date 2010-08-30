From: thomas.nemeth@betatech.fr (Thomas Nemeth)
Date: Mon, 30 Aug 2010 14:44:21 +0200
Subject: iMX31 power management
Message-ID: <201008301444.21510.thomas.nemeth@betatech.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


    Hi.

    I'm currently struggling trying to make suspend to RAM work for the
    iMX31 processor. As the pm functions were not implemented, I added
    a pretty straightforward pm "driver".

    It works to a point. The processor seems really sleeping. But where
    the heck is Prince Charming ? It does not want to wakeup else :( I
    can't make the DOZE mode, State Retention mode and Deep Sleep mode
    to work. Does anybody know how ?

    I added in attachment the code I adapted from 2.6.22 so that it
    integrates better with current kernels.


Thomas.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pm.c
Type: text/x-csrc
Size: 4152 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100830/d8328997/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100830/d8328997/attachment.sig>
