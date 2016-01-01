From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 22:53:33 +0100
Subject: [PATCH v3 RESEND 0/2] WM8505/WM8650 DT fixes for SD card
 controller
In-Reply-To: <20160101203230.1dc5e655@v1ron-s7>
References: <1451655492-2569-1-git-send-email-v1ron@mail.ru>
 <7786478.TezhYjHkEF@wuerfel> <20160101203230.1dc5e655@v1ron-s7>
Message-ID: <9863929.DgKyDlgJ1e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 January 2016 20:32:30 Roman Volkov wrote:
> > Applied both to next/dt, thanks a lot for following up!
> > 
> > Let me know if you think this should go into stable backports as well,
> > I did not apply it to the fixes branch as you don't have a
> > 'Cc: stable at vger.kernel.org' tag and it has never worked so far.
> 
> Yes, this must go into the stable too. Let me know if I must change
> something or resend.

I can put them in the fixes branch with the appropriate stable
tag myself, but please clarify whether we need just the first or
both patches there. It looks to me that the second one while
correct only addresses a cosmetic problem and everything works
without it.

	Arnd
