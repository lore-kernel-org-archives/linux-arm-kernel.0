From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Mar 2013 23:35:54 +0100
Subject: Integrator PCI base dilemma
In-Reply-To: <20130322211339.7A5F82014CE@gemini.denx.de>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <201303211302.19058.arnd@arndb.de>
 <20130321234004.GV4977@n2100.arm.linux.org.uk>
 <201303220948.28092.arnd@arndb.de>
 <20130322103740.GW4977@n2100.arm.linux.org.uk>
 <CACRpkdb5Q+EtM0GGaLFNUj1A12zVrcyUxzRvfEOpcH4-pVuasA@mail.gmail.com>
 <20130322211339.7A5F82014CE@gemini.denx.de>
Message-ID: <CACRpkdY_qj7VBKBSCsK3mnx=V5DURY-g1fHGVwDBz2WUheB=Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 10:13 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Linus Walleij,
>
> In message <CACRpkdb5Q+EtM0GGaLFNUj1A12zVrcyUxzRvfEOpcH4-pVuasA@mail.gmail.com> you wrote:
>>
>> I'm on U-boot for this thing, I wonder if that can do x86
>> emulation to initialize VGA card. I guess I'm about to learn.
>
> Guess what the code in  drivers/bios_emulator  might be good for...

Thanks Wolfgang!

I hacked around a bit and actually got it to compile for ARM.

Now I just need to write an S3 driver or find an ATI Radeon
card since that seems to be supported already.

Yours,
Linus Walleij
