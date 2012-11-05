From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Mon, 5 Nov 2012 06:44:10 +0000
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
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA63234@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 04, 2012 at 23:07:44, Linus Walleij wrote:
> On Tue, Oct 30, 2012 at 3:12 PM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> 
> > I completely understood this named modes, I have added named
> > modes like this in am335x-xxx.dts files
> 
> I do not understand how the pinctrl-single dts files work actually,
> so please get Tony to review this part.
> 
> > I think "pinctrl-1" state will be used in driver
> > suspend/resume calls.
> 
> Hopefully, I think you should test the code and monitor the
> system to make sure the right thing happens.

I will test while adding "pinctrl-1" data to .dts files.

> 
> > I have the pinmux/conf settings for default state but fully
> > optimized pinmux/conf values in idle & suspend states are not
> > available yet.
> 
> You have defined a "sleep" state which is what should be used
> for suspend? Or do you mean that you do have a state but
> you're just not defining it to the most optimal setting yet?

Yes, sleep state is used for suspend. Regarding to this suspend
state fully optimized pinmux/conf values are not available.

Thanks
AnilKumar
