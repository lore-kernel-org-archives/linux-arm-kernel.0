From: marex@denx.de (Marek Vasut)
Date: Mon, 21 Jan 2013 22:53:09 +0100
Subject: [PATCH 1/2] iio: mxs: Add MX23 support into the IIO driver
In-Reply-To: <CAHXqBFJ5=P2OHez74gK-DBT+3O=KHoHjffxRAe2u-9ppXOmExA@mail.gmail.com>
References: <1358798722-25102-1-git-send-email-marex@denx.de>
 <201301212232.52161.marex@denx.de>
 <CAHXqBFJ5=P2OHez74gK-DBT+3O=KHoHjffxRAe2u-9ppXOmExA@mail.gmail.com>
Message-ID: <201301212253.10332.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Micha? Miros?aw,

[...]

> >> I'm asking, because you don't use this number anywhere other than in
> >> mxs_lradc_probe()
> >> and there only to dereference the irq-names table. After that the
> >> structure and number
> >> are forgotten.
> > 
> > Certainly, so far it's used only this way. But please see my argument
> > about register layout, that's why I went down this road of abstraction.
> 
> Hmm. Then is IMX23 LRADC going to just work after this series
> (assuming I don't use unsupported features) or this needs more patches
> to be usable?

It's gonna work, touchscreen will work as well. You won't have the touchbuttons, 
but when these're gonna be implemented, we will need to be careful to enable 
them only for mx28.

Best regards,
Marek Vasut
