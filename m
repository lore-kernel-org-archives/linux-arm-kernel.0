From: till.klocke@yetu.com (Till Klocke)
Date: Wed, 14 May 2014 11:17:32 +0200
Subject: USB with 3.14.3 not working on Freescale i.mx6
Message-ID: <CACWLcfv6akXuM59m_hX-xB=iQYA4iAx7fZ0T5ZB3-7ik-1GZMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Currently I am trying to get a recent and stable Linux kernel running
on a Phytec PhyFlex board based on the i.mx6 processor from Freescale.
I saw that this processor is supported by the Linux kernel and
compiled it. It boots successfull and everything I tested so far seems
to be working except for USB. When I activate debugging for the LibUSB
and do a 'lsusb' I get the following:

[timestamp] [threadID] facility level [function call] <message>
--------------------------------------------------------------------------------
[ 0.000000] [0000073a] libusbx: error [op_init] could not find usbfs
unable to initialize libusb: -99

I am basically using the default configuration delivered with the
kernel. Did anyone has successfully ran a recent Linux kernel on a
i.mx6 based board and give me some advice on how to solve my USB
problem?

Thanks in advance,

Greetings
