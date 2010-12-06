From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 12:58:14 +0000
Subject: [PATCH 47/54] ARM: versatile: irq_data conversion.
In-Reply-To: <4CFCD2B0.6090902@ru.mvista.com>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130134119.GV15575@mail.wantstofly.org>
	<4CFCD2B0.6090902@ru.mvista.com>
Message-ID: <20101206125814.GD31777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 03:10:24PM +0300, Sergei Shtylyov wrote:
>> -	irq -= IRQ_SIC_START;
>> +	unsigned int irq = d->irq - IRQ_SIC_START;
>
>    Perhaps should've inserted an empty line here...
>
>>   	writel(1<<  irq, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);

Oh, it's _your_ mailer which is totally buggering up the spacing.  Please
get an email client which doesn't think it has the right to randomly
reformat text.
