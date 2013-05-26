From: pavel@denx.de (Pavel Machek)
Date: Sun, 26 May 2013 20:11:16 +0200
Subject: [PATCHv4 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
In-Reply-To: <201305242058.34332.arnd@arndb.de>
References: <1369410080-436-1-git-send-email-dinguyen@altera.com>
 <201305241912.53751.arnd@arndb.de>
 <1369418588.9717.0.camel@linux-builds1>
 <201305242058.34332.arnd@arndb.de>
Message-ID: <20130526181116.GA16409@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2013-05-24 20:58:34, Arnd Bergmann wrote:
> On Friday 24 May 2013, Dinh Nguyen wrote:
> > I apologize for that. Will make sure to include a [PATCH 0/6] message in
> > the future.
> 
> No worries, I actually saw now that my only other comment was also
> wrong, as you have the binding I was looking for in patch 5/6.

Could you take the series through your tree?

Patches 1,2,4,5/6 are mostly local to arch/arm, 3/6 is stuff Dinh is
listed as a maintainer for, and 6/6 is fairly socfpga-specific,
too. (I guess Dinh could add MAINTAINERs entry for that...).

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
