From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 8 May 2011 22:13:29 +0200
Subject: [PATCH 2/2] mmci: fixup sg buffer handling in mmci_pio_irq.
In-Reply-To: <20110508102219.GG27807@n2100.arm.linux.org.uk>
References: <1304594063-19408-1-git-send-email-linus.walleij@stericsson.com>
	<20110508102219.GG27807@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=KswoqCqb_favD7EdX0NE47rM7Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 8, 2011 at 12:22 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 05, 2011 at 01:14:23PM +0200, Linus Walleij wrote:
>> The patch fix the problem by checking result of mmci_pio_write().
>>
>> The fault was introduced in the change:
>> ? ? ? I2e506ec1f5a7fadf9780c18d8d31573eaf048273
>> ? ? ? MMCI: Fixup sg buffer handling in pio_write
>
> I assume this isn't for mainline as that commit isn't present.

No I screwed up, I will post a combined patch with both and an
explanation instead, only relates to SDIO FWIW.

Thanks for your patience.

Yours,
Linus Walleij
