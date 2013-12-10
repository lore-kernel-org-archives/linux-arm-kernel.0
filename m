From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 10 Dec 2013 16:47:00 +0400
Subject: [PATCH v2 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <CACRpkdYVsGSyMS6sSTqqJ4XrE3GqpWkJsY7GDazi5ix7xjKQ=Q@mail.gmail.com>
References: <1385879185-22455-3-git-send-email-ynvich@gmail.com>
 <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <CACRpkdYVsGSyMS6sSTqqJ4XrE3GqpWkJsY7GDazi5ix7xjKQ=Q@mail.gmail.com>
Message-ID: <1386679620.7152.226.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-10 at 13:43 +0100, Linus Walleij wrote:
> Argh! Now you're adding another user for a legacy custom pin control
> implementation. But if noone is going to modernize PXA2xx what
> can we do :-/

I've rewritten the device to use device tree and posted patch series for
that.

I will also implement LP-8x4x custom irq controller in drivers/irqchip/
