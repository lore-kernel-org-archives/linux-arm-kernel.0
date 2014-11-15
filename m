From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 15 Nov 2014 21:57:03 +0100
Subject: [PATCH 2/2] usb: gadget: pxa27x_udc: prepare/unprepare clocks in
 pxa-ssp
In-Reply-To: <1416081030-28260-2-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Sat, 15 Nov 2014 22:50:30 +0300")
References: <1416081030-28260-1-git-send-email-dbaryshkov@gmail.com>
 <1416081030-28260-2-git-send-email-dbaryshkov@gmail.com>
Message-ID: <878ujcfahs.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unrepapre().

No, there are already patches for this in Felipe's next tree :
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next

Cheers.

--
Robert
