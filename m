From: joe@perches.com (Joe Perches)
Date: Tue, 13 Jul 2010 09:20:01 -0700
Subject: [PATCH 1/5] pxa: Sane naming of gpios for palm platform
In-Reply-To: <AANLkTilWYmIFgh7SYDQM07FKbk2RlwUpEhKd4nEKb6nw@mail.gmail.com>
References: <1279006733-17731-1-git-send-email-marek.vasut@gmail.com>
	<AANLkTikH7VE6W8x5Y_r0YO1SDhOvEBEIeDUibuZ4lzKx@mail.gmail.com>
	<201007131158.38699.marek.vasut@gmail.com>
	<AANLkTilWYmIFgh7SYDQM07FKbk2RlwUpEhKd4nEKb6nw@mail.gmail.com>
Message-ID: <1279038001.1501.408.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-13 at 18:20 +0800, Eric Miao wrote:
> > GPIO_NR was never intended to be used. It's some stupidity with historic roots.
> > (NR == number ... it was intended to be substituted, but never was ... time to
> > do it).
> I think it's acceptable - my preferable choice would be GPIO_xxxx. But
> the idea of encoding GPIO number into the macro itself is not good. E.g.
> GPIO_MMC_DETECT is self explanatory, no need for GPIO9_MMC_DETECT.
> Later you find the GPIO number is actually 10, now you have to modify
> _every_ place this macro appears, instead of a one liner patch.

I agree with Eric.
Another scenario is another board comes along nearly
but not quite identical.

>>> +70kb duplicated email reply crud

Please remember to trim unnecessary stuff.
