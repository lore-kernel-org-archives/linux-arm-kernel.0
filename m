From: elder@linaro.org (Alex Elder)
Date: Thu, 27 Mar 2014 08:33:38 -0500
Subject: mach-spear SMP questions
Message-ID: <533428B2.2050906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm doing some code cleanup and have a question about
something related to SMP in mach-spear.  Can anyone
help me with these questions?

My question has to do with how secondary cores start for
SMP.  Most machines need to send a wakeup event from the
boot core to each secondary core as it is told to start.
But mach-spear does not do this.  I'd like to know if this
is an oversight, or confirm that this is simply not necessary
for this machine.

Also, while most machines touch a memory location and then
do a targeted cache involving only that location, mach-spear
does a full flush.  Is the full flush really required for
some reason?

Thanks.

					-Alex
