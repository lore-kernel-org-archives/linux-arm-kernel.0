From: rob.garrett@blacktrace.com (Robert Garrett)
Date: Wed, 25 Nov 2009 08:50:43 +0000
Subject: Changing HZ value in linux kernel
Message-ID: <3523d4970911250050u4e5fd676w51585fd65c7798c7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I have a question about timers in the linux kernel.  I'm working with an
embedded ARM processor (pxa-x270) and linux kernel version 2.6.16.  One of
the drivers I'm writing needs 1ms timing accuracy and I found I could
achieve this using kernel timers and changing the value of HZ to 1000 (the
default is 100).

However, I now find that mdelay and udelay etc. don't give the correct
delays.  This causes a problem in one of the other drivers I have, but I'm
also worried that other code within the kernel may have broken aswell.

How do I fix the delays so that they still work?  Or am I going about this
in completely the wrong way - is there a better way for me to get 1ms
resolution timers in the kernel?

Thanks,

Robert Garrett
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091125/21643504/attachment-0001.htm>
