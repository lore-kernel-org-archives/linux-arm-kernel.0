From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 20:13:42 +0100
Subject: [Bulk] Re: [PATCH 2/6] pinctrl: gpio: vt8500: Add pincontrol
 driver for arch-vt8500
In-Reply-To: <1363201721.2452.8.camel@gitbox>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
 <513E09FE.5040104@wwwdotorg.org> <1363062095.23051.16.camel@gitbox>
 <CACRpkdYTKk-fPkUX_jOoHoqxgpsEh2L1ryGC7VSNiAbsmOtcEg@mail.gmail.com>
 <1363201721.2452.8.camel@gitbox>
Message-ID: <CACRpkdauBPbOwk9fjmrwZx_t7dwLyeHznG7U_ebg=T36uLF-cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 8:08 PM, Tony Prisk <linux@prisktech.co.nz> wrote:

> The only reason we use this register at present is to enable the LCD
> selection (bit 0 in this example - bit 31 on the other SoCs).

OK then I guess there is not immediate need for that to be in
the device tree right now? I'm happy if you open-code that.

> Other than that, we rely on uboot to have 'done the right thing'.

Do you have the U-boot sources to inspect on how this works
then? You are legally entitled to them...

Or do you mean some earlier proprietary step has set them
up, or something like power-on state? Then I'm following...

Yours,
Linus Walleij
