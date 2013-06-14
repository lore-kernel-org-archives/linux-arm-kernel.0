From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 23:47:36 +0200
Subject: [PATCH 00/28] Twenty eight patches big Exynos cleanup
In-Reply-To: <5750530.AyJQs5JHPZ@wuerfel>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
 <5750530.AyJQs5JHPZ@wuerfel>
Message-ID: <2203616.54AcBMXmhk@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Friday 14 of June 2013 23:26:04 Arnd Bergmann wrote:
> On Friday 14 June 2013 21:32:36 Tomasz Figa wrote:
> > As I promised, I am doing some spring (or rather summer) cleaning
> > of Exynos- and Samsung- related code.
> > 
> > This first part consists mostly of removing dead code remaining after
> > removal of ATAGS support for Exynos, but several patches cleans up
> > other things found by the way.
> > 
> > See particular patches for more detailed description.
> > 
> > On Exynos4210-based Trats board:
> > Tested-by: Tomasz Figa <t.figa@samsung.com>
> > 
> > Build tested every patch with s3c6400_defconfig, s5pv210_defconfig
> > and exynos_defconfig.
> 
> Great stuff. I unfortunately did almost the exact same patch since I
> did not know you were on it too.

Hmm, I didn't see it. Looks like we need some task synchronization. :)

> Yours looks better in some details,
> and your patch descriptions are /much/ better than my single large
> patch.
> 
> I'll try to cross-check the two series to see if there is anything
> you missed that was in my patch set.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

OK, thank you.

I will continue my spring (summer) cleaning session on Monday, probably 
focusing on init and PM code, but who knows what else can be found in this 
code. ;)

Best regards,
Tomasz

> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in the body of a message to
> majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
