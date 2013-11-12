From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 14:44:54 +0100
Subject: [PATCH 1/4] ARM: sa1100: add irq handler to prepare
 MULTI_IRQ_HANDLER
In-Reply-To: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
References: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
Message-ID: <CACRpkdb5woGjw1L3A=8vrRx0mW2tOFtKSn0BPcGwpX3CU+EtpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 1, 2013 at 11:52 AM, Dmitry Eremin-Solenikov
<dmitry_eremin@mentor.com> wrote:

> Add sa1100_handle_irq implementating handle_irq for sa1100 platform.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>

As it happens I had a larger series doing this and some more refactorings
in the SA1100 irq driver, like using irqdomain for mapping all IRQs. Sorry
for not noting this earlier :-(

I cleaned it up and sending it now and we can have a fight on
which patches to take ;-)

Yours,
Linus Walleij
