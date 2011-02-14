From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Feb 2011 09:39:32 +0100
Subject: [RFC] Inter-processor Mailboxes Drivers
In-Reply-To: <20110214.093257.58795266617213863.Hiroshi.DOYU@nokia.com>
References: <4D55A7F7.5090700@mentor.com>
	<AANLkTikP0P9S1VgiU_yT53f-kZq0JMLBJoVWigAy8YWB@mail.gmail.com>
	<AANLkTikoExk30pqdcHXCA2K_oJB=VJ5_AnCkoYUrEt3X@mail.gmail.com>
	<20110214.093257.58795266617213863.Hiroshi.DOYU@nokia.com>
Message-ID: <AANLkTimnHHhYKnvUgsMo_jsKaYdY+XuABZ+FV0p25JLi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 8:32 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:

> OMAP mailbox is the interrupt driven 32bit unit H/W FIFO to other
> cores.

How is it used? Is it a low-traffic (like single 32bit words etc) signal
control-path link while the actual high-throughput data-path is done
with shared memory? (That is how the db5500 mbox works anyways.)

Linus Walleij
