From: therealbadguy@gmail.com (Badguy Badguy)
Date: Wed, 14 Apr 2010 14:02:47 -0600
Subject: iMX31 LogicPD LiteKit Kernel 2.6.33.2
Message-ID: <w2i3f34cd261004141302xdeb23378hfc4d795a6c9811c2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

 I am attempting to boot the 2.6.33.2 Kernel on the LogicPD LiteKit iMX31.
we have a board based on this one, and I am using it and the dev kit with no
success.

I see a lot of support in the mainline kernel for this board, is it safe to
assume someone is able to boot this board using it?

I am running the lolo bootloader from Logic, version 2.4.0.

I have compiled the kernel using a fairly new ltib environment.

Currently I run 2.6.19.2 from Freescale / Logic with success but now desire
to upgrade the kernel to something with better MMC support, I am not stuck
on 2.6.33.2 if someone can recommend a newer kernel that has some of the
support I desire.

When I attempt to boot the kernel, It hangs and this is my only output:
 Uncompressing Linux... done, booting the kernel.

 I have dug around a little bit as I get my feet wet in kernel
initialization, and would appreciate any debug pointers or solutions or
direction on how to solve this.

 I have located two other people posting to these mailing lists with similar
problems indicating it binds up in some asm prior to start_kernel so far my
analysis is indicating the same thing.

 Thanks in advance for any response I receive.

 -Chris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100414/d5b60a1c/attachment.htm>
