From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 18 Feb 2017 15:05:18 +0100
Subject: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
In-Reply-To: <3658176.ffWihUmtIa@wuerfel>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <2695922.yyinjvNuJK@wuerfel>
 <CACRpkdb=BqihykWo3egtNW1VKE2-FV+nJQQVYOc2GdCvh1fMng@mail.gmail.com>
 <3658176.ffWihUmtIa@wuerfel>
Message-ID: <CACRpkdZ4OKCifVogYN3MCnyZ6y9U_Pg2tNsjy5f02wxGOykAhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 3:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday, February 4, 2017 7:43:15 PM CET Linus Walleij wrote:

> Did you notice my other comment below (quoting from my own
> message)?
>
>> > +
>> > +     bus = pci_scan_root_bus(&pdev->dev, 0, &gemini_pci_ops, p, &res);
>>
>> Can you try using the new pci_register_host_bridge() API?

Yes. It crashes badly when I try it so I'm still trying to figure this out...
If I do I will send an iteration.

Yours,
Linus Walleij
