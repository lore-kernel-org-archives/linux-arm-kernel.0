From: cjb@laptop.org (Chris Ball)
Date: Sat, 24 Aug 2013 23:18:14 -0400
Subject: [PATCH v4 2/5] mmc: atmel-mci: prepare clk before calling enable
In-Reply-To: <1374133132-17556-1-git-send-email-b.brezillon@overkiz.com>
 (Boris BREZILLON's message of "Thu, 18 Jul 2013 09:38:52 +0200")
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
 <1374133132-17556-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <87li3qsbk9.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 18 2013, Boris BREZILLON wrote:
> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> avoid common clk framework warnings.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Okay, pushed to mmc-next for 3.12.

Boris, you got feedback from Thomas Petazzoni and Russell King, but
you didn't CC either of them on the patch v4, and you didn't write a
changelog explaining the differences between patches v3 and v4 --
please do both of those next time.

Also, it looks like the Ack from Ludovic happened away from the MMC
list, since I don't see a message from Ludovic on the thread here.
It would be better if the Ack happened somewhere I can see it.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
