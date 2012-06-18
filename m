From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 18 Jun 2012 13:28:34 +0200
Subject: [PATCH] ARM: ux500: bump i2c bus speed to 400kHz
In-Reply-To: <CACRpkdZENi8PCdjmr-Ypey95HjDmEZmpJtqEC49SbwPBCfqr7Q@mail.gmail.com>
References: <1339955837-26691-1-git-send-email-linus.walleij@stericsson.com>
 <201206180106.21108.marek.vasut@gmail.com>
 <CACRpkdZENi8PCdjmr-Ypey95HjDmEZmpJtqEC49SbwPBCfqr7Q@mail.gmail.com>
Message-ID: <201206181328.34644.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Linus Walleij,

> On Mon, Jun 18, 2012 at 1:06 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> >> From: Linus Walleij <linus.walleij@linaro.org>
> >> 
> >> Some recent discussion revealed inconsistency in the board file
> >> for the MOP500 family. The board can very well do 400kHz on
> >> the I2C busses, so make it do that.
> > 
> > Shouldn't this be controlled by DT?
> 
> They can be controlled by Device Tree after Lee's patch I think.
> 
> > Some of the i2c devices can't do 400kHz.
> 
> Which ones? This works find on the MOP500/HREF board, are you referring
> to Snowball devices?

I had issues with some omnivision cameras, but they were indeed quite old. My 
rant was rather about not closing the door for 100kHz if it was ever needed. But 
like you said above, if it can be changed after applying the aforementioned 
patch, that's ok.

Thanks for clearing this up, sorry for pestering you.

> Yours,
> Linus Walleij

Best regards,
Marek Vasut
