From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 16:04:16 +0200
Subject: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
In-Reply-To: <5256AA7F.8030005@ti.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost>
 <5256AA7F.8030005@ti.com>
Message-ID: <CACRpkdZx5+OCcQytkpjd7_nz4hw6VXoXOS0LByKgJ8_cQjbA4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 3:24 PM, Roger Quadros <rogerq@ti.com> wrote:

> I think pcs_irq_set_wake() is where need to control system wakeup behaviour for the irq.
> This is where we should be able to change WAKEUP_EN bit of the pad
> to enable/disable system wakeup for that pad and also call _reconfigure_io_chain().

As an innocent bystander who has no clue what the _reconfigure_io_chain()
is about can you tell me what this is all about?

Is this another one of the OMAP forked paths where you must call back into
the machine with a special callback from each and every driver?

Yours,
Linus Walleij
