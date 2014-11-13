From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 13 Nov 2014 15:05:12 +0100
Subject: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
In-Reply-To: <545D0074.7060205@ti.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <2024276.CFr3nVUAlA@vostro.rjw.lan>
 <CAPDyKFp=T8Luomeaoz5Y=eLAuFaOfdb+-aoU3QVnpjoDYVKPjg@mail.gmail.com>
 <17707586.6KbjDf5Kep@vostro.rjw.lan>
 <CAPDyKFo-On2MfqHk081o_JZvwbrbi0=n9h6o7A9dJ+X4c8goKg@mail.gmail.com>
 <545D0074.7060205@ti.com>
Message-ID: <20141113140512.GB18995@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> 2) There are no requirements for arch/platforms/drivers to work in both cases
> CONFIG_PM_RUNTIME=y/n. But they must be built without errors/warning for both
> cases.

I don't think where you got that. They are config options, they should
work.

It is prefer not to compile than to compile but not work.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
