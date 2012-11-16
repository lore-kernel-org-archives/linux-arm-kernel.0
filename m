From: avictor.za@gmail.com (Andrew Victor)
Date: Fri, 16 Nov 2012 22:46:40 +0200
Subject: [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
In-Reply-To: <50A6119E.8010303@atmel.com>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
 <20121116095352.GF4398@game.jcrosoft.org>
 <50A6119E.8010303@atmel.com>
Message-ID: <CAFumwP24g0Rt4_fXSE7c8GehLJYumHzUD=UvWV88HThmUp_CGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> Yes, during previous attempt to remove the files, Andrew said that it
> was used internally in his former company. I had no serious reason to
> remove it, so we kept it back then.
> But now it seems the situation has evolved and we must consider the move
> to a single kernel image and the will to clean the include/asm/mach
> directory.

SAN People will just need to maintain a custom patch / driver for this.
No reason to delay the progress of mainline.

Acked-By: Andrew Victor <avictor.za@gmail.com>
