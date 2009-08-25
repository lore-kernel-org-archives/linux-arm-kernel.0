From: mishal@softerra.com (Mikhail Lodygin)
Date: Tue, 25 Aug 2009 19:35:10 +0300
Subject: 6410 issues with samsung-ap-2.6
In-Reply-To: <200908242149.n7OLnU6d017655@chronolytics.com>
References: <200908242149.n7OLnU6d017655@chronolytics.com>
Message-ID: <4A9412BE.40305@softerra.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Have you tried mainstream kernel? Samsung's kernel is for reference
purposes only I believe.
I hanvn't use keys functionality but gpio and interrupt works well in
mainstream.
Mikhail.
David F. Carlson wrote:
> List-ies,
>
> I am (trying) to use the recently released git kki_ap/samsung-ap-2.6 which is supposedly a decent 6410 tree.
>
> I am having trouble with the the input gpio_keys code that does a "gpio_to_irq()" to get the gpio to irq mapping.
>
> This call always fails for the 6410 (ENXIO).  I see no code for the 6410 to get a irq.
>
> Is there a better tree to integrate my 6410-based device with?  (I am having other "issues" with this git tree and the samsung folks are not helpful...)
>
> Thanks in advance,
>
> David F. Carlson    Chronolytics, Inc.  Rochester, NY
> mailto:dave at chronolytics.com            http://www.chronolytics.com
>
> "The faster I go, the behinder I get." --Lewis Carroll
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>   
