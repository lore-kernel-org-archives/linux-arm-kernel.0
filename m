From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 23 Dec 2010 21:51:20 +0300
Subject: [PATCH 47/54] ARM: versatile: irq_data conversion.
In-Reply-To: <20101206125814.GD31777@n2100.arm.linux.org.uk>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130134119.GV15575@mail.wantstofly.org>
	<4CFCD2B0.6090902@ru.mvista.com>
	<20101206125814.GD31777@n2100.arm.linux.org.uk>
Message-ID: <4D139A28.3090602@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Russell King - ARM Linux wrote:

>>> -	irq -= IRQ_SIC_START;
>>> +	unsigned int irq = d->irq - IRQ_SIC_START;

>>    Perhaps should've inserted an empty line here...

>>>   	writel(1<<  irq, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);

> Oh, it's _your_ mailer which is totally buggering up the spacing.  Please
> get an email client which doesn't think it has the right to randomly
> reformat text.

    Thunderbird is not exactly only my client. :-)
    And I haven't noticed it randomly reformatting text before. What it does is 
eating spaces before & in the quoted text (and inserting them afterwards).

WBR, Sergei
