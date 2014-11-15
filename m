From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 15 Nov 2014 22:15:20 +0100
Subject: [PATCH] ASoC: pxa: prepare/unprepare clocks in pxa-ssp
In-Reply-To: <1416081106-28324-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Sat, 15 Nov 2014 22:51:46 +0300")
References: <1416081106-28324-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <874mu0f9nb.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unrepapre().
  clk_disable_unprepare() (typo)

Otherwise, look good to me, ack.

Cheers.

--
Robert
