From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Nov 2012 08:27:33 -0800
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <CACRpkdY_db3ju4LVnoR=0Wq8TFUxa48jNFGhvGM-3uSrmGZVew@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
 <CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
 <20121001154451.GI4840@atomide.com>
 <CACRpkdaib2M1_UwSbyUG8qwZC2h7xaT5VU7WMj=y+h4S4LianQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3F22E@DBDE01.ent.ti.com>
 <CACRpkdaeu3JaLqSbqETT=D0mdUu5VpwRpS_Xohd6M963rw8QMg@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA5C598@DBDE01.ent.ti.com>
 <CACRpkdY_db3ju4LVnoR=0Wq8TFUxa48jNFGhvGM-3uSrmGZVew@mail.gmail.com>
Message-ID: <20121105162733.GK4953@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [121104 09:39]:
> On Tue, Oct 30, 2012 at 3:12 PM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> > I have two options now
> > - add only default states for now, I can add reset of
> > the state details once suspend/resume is supported.
> > - add same values in all the states, modify those once
> > suspend/resume is added for AM335x.
> 
> The OMAP maintainer gets to choose how this is to be done,
> it's none of my business :-)

Either way is fine with me as long as the changes have been
tested and you don't have to redo things once you have
suspend and resume working.

Regards,

Tony
