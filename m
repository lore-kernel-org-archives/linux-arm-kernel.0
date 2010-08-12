From: urx.forever@gmail.com (Yuri Ludkevich)
Date: Thu, 12 Aug 2010 10:02:20 -0000
Subject: Colibri PXA320 Power management question
Message-ID: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there :)

I have a question about power management of Colibri PXA320 module:
I found that bits PVE and FVE in PVCR register are disabled,
so at frequency change voltage will not change.

If I turn on PVE and FVE with pxaregs tool - voltage changes just fine.
Where are suitable place in the kernel for PVCR initialization?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100812/2d01eea3/attachment-0001.html>
