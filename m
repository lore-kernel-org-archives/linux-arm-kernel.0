From: v1ron@mail.ru (Roman Volkov)
Date: Sat, 2 Jan 2016 12:12:39 +0300
Subject: [PATCH v3 RESEND 0/2] WM8505/WM8650 DT fixes for SD card
 controller
In-Reply-To: <9863929.DgKyDlgJ1e@wuerfel>
References: <1451655492-2569-1-git-send-email-v1ron@mail.ru>
 <7786478.TezhYjHkEF@wuerfel> <20160101203230.1dc5e655@v1ron-s7>
 <9863929.DgKyDlgJ1e@wuerfel>
Message-ID: <20160102121239.01b64a0c@v1ron-s7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? Fri, 01 Jan 2016 22:53:33 +0100
Arnd Bergmann <arnd@arndb.de> ?????:

> On Friday 01 January 2016 20:32:30 Roman Volkov wrote:
> > > Applied both to next/dt, thanks a lot for following up!
> > > 
> > > Let me know if you think this should go into stable backports as
> > > well, I did not apply it to the fixes branch as you don't have a
> > > 'Cc: stable at vger.kernel.org' tag and it has never worked so far.  
> > 
> > Yes, this must go into the stable too. Let me know if I must change
> > something or resend.  
> 
> I can put them in the fixes branch with the appropriate stable
> tag myself, but please clarify whether we need just the first or
> both patches there. It looks to me that the second one while
> correct only addresses a cosmetic problem and everything works
> without it.

Correct, everything works without the second one. One of reviewers
noticed that addresses are different between WM8505 and WM8650 where
the hardware is the same. If such trivial changes are not accepted,
please do not apply.

Happy New Year,
Roman
