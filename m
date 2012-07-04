From: csutfirst@gmail.com (csutfirst)
Date: Wed, 4 Jul 2012 09:25:17 +0800
Subject: a question about cspi dma on i.mx31
Message-ID: <CAB5=OOTWqNjbS_sKL13nKizF+w87Uv3ainzUm697TeV7pUKuKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI, All,
If it's not correct to ask a question by this way, pls execuse me.

We are developing a system based on i.mx31, and the software is based on
linux 2.6.28 released by freescale.
In our system, the cspi port is configured as a slave port, 32bit mode. As
the released source code does not
support CSPI DMA., we re-write a linux driver to make it work. The driver
do work ,but we get the big-endian
data.That is ,in the master  data 0x44332211 was sent,but we get 0x11223344
in our dma callback. I don't know
whether if the i.mx31 can fix the byte-order.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120704/51f13125/attachment.html>
