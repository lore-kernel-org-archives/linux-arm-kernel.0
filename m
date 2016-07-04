From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 04 Jul 2016 14:56:13 +0100
Subject: [PATCH 2/2] i2c: versatile: Convert to use resource managed
 devm_* APIs
In-Reply-To: <CAFRkauAarcYw6tCvM0_1VL-Wpf_OeLY=LEiR33DnQ1Q+2_C_KQ@mail.gmail.com>
References: <1460644236.6039.2.camel@ingics.com>
 <1460644306.6039.3.camel@ingics.com>
 <CAFRkauAarcYw6tCvM0_1VL-Wpf_OeLY=LEiR33DnQ1Q+2_C_KQ@mail.gmail.com>
Message-ID: <1467640573.23717.3.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dnia 2016-06-25, Sat o godzinie 09:41 +0800, Axel Lin pisze:
> 2016-04-14 22:31 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> > Use devm_* APIs to simplify the code a bit.
> > This patch also fixes the memory leak when unload the module.
> > 
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> > Hi,
> > I don't have this h/w, I'd appreciate if someone can test this
> > patch.
> 
> Obviously the module unload path has memory leak.
> Just wondering if anyone can review/test this patch.

Gentlemen? (referring to the VE maintainers here)

Original thread: thread.gmane.org/gmane.linux.drivers.i2c/27277

Thanks!

Pawel
