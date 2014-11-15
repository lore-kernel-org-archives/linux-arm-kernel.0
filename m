From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 15 Nov 2014 21:53:22 +0100
Subject: [PATCH 1/2] usb: gadget: pxa25x_udc: prepare/unprepare clocks in
 pxa-ssp
In-Reply-To: <1416081030-28260-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Sat, 15 Nov 2014 22:50:29 +0300")
References: <1416081030-28260-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <87d28ofanx.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unrepapre().
              => clk_disable_unprepare() (typo)

Otherwise, good for me, ack.

Cheers.

--
Robert
