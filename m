From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 5 Jul 2011 18:36:24 +0300
Subject: RTC backup on omap3 (overo)
In-Reply-To: <AD1D79D65ED429499381113CFECBBE48128DA6CF@EINTMBX02.einet.ad.eivd.ch>
References: <AD1D79D65ED429499381113CFECBBE48128DA6CF@EINTMBX02.einet.ad.eivd.ch>
Message-ID: <20110705153624.GA2331@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,

On Tue, Jul 05, 2011 at 02:35:12PM +0000, Gerber Patrick wrote:
> I am using an over Fire with an omap3530. I have added a small Lithium 
> backup battery to the TWL4030 for RTC backup as recommanded by Gumstix.
> I have tried to set the time with date command and shutdown the overo and 
> remove power. After restart the date is not the one that I have set but a 
> default one (always the same).
> 
> Does anybody have already experienced this ? Do you have any idea ?

Do 'hwclock -w' to set the RTC clock from the system clock. This should do the 
trick, assuming that you have the RTC driver compiled, or loaded as a module.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
