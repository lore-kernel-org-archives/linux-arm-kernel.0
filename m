From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Sep 2014 19:32:31 +0200
Subject: [PATCH 1/2] gpio: Add driver for AXM55xx SSP chip selects
In-Reply-To: <20140904170630.GL29327@sirena.org.uk>
References: <1409576021-24828-1-git-send-email-anders.berg@avagotech.com>
 <1409576021-24828-2-git-send-email-anders.berg@avagotech.com>
 <CACRpkdby4H-fivNn_kG2uL0EjsCGAc+t6OyFi0+VcNGf2Z9NQA@mail.gmail.com>
 <20140904170630.GL29327@sirena.org.uk>
Message-ID: <CACRpkdZEoBan=Lqr1T-iY41U9NfMA_MCLX3LA=juw7X4pmRvSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 4, 2014 at 7:06 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 04, 2014 at 07:04:44PM +0200, Linus Walleij wrote:
>> I need an ACK from Mark Brown on this before I apply.
>> The driver seems to do what it should, but I need Mark to
>> be OK with exporting the CS signals from an SSP/SPI block
>> to be exposed to Linux as GPIOs.
>>
>> (Top-posting and quoting patch verbatim so Mark gets it.)
>
> I don't see any sort of reasoning for this?

Maybe there was some earlier, but this is an excellent opportunity
to repeat it... So Anders: why do you want to do this?

Yours,
Linus Walleij
