From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 29 Jul 2013 09:27:32 +0100
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4OzgqH5AiOtismEGop5Y++gvu1ZVZEXhwJB3f-6_eczkqQ@mail.gmail.com>
References: <2469263.vMN09Q7Tzi@flatron>
 <CAKON4OzgqH5AiOtismEGop5Y++gvu1ZVZEXhwJB3f-6_eczkqQ@mail.gmail.com>
Message-ID: <1375086452.2923.106.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-07-28 at 21:30 -0400, jonsmirl at gmail.com wrote:
> Imagine what might be possible with device trees in a few years...
> 
> A single kernel image can load on any embedded system. The device tree
> sorts out all of the driver loading and tells how everything is wired
> together. There is zero board specific code in the kernel. We're
> getting close to this one.

Weren't we doing this years ago on PowerPC? I'm sure I've heard of
Freescale bringing up a new SoC without touching a line of kernel code.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/f5c1e814/attachment.bin>
