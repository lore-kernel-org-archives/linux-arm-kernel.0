From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 14 Jan 2013 18:53:07 +1300
Subject: [Bulk] [PATCH] timer: vt8500: Move timer code to
 drivers/clocksource
In-Reply-To: <1358142455.25591.1.camel@gitbox>
References: <1358140171-25390-1-git-send-email-linux@prisktech.co.nz>
 <1358140171-25390-2-git-send-email-linux@prisktech.co.nz>
 <1358140429.25452.1.camel@gitbox> <1358142455.25591.1.camel@gitbox>
Message-ID: <1358142787.28351.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Oh grr.. forget this completely. It doesn't take into account the
> patches I already sent for WM8850.
> 
> I guess it needs to be based on timer/cleanup + vt8500/wm8x50.
> 
> Need a little advise on how to handle this one please :)
> 
> Regards
> Tony P

Turns out the original patch applies cleanly on timer/cleanup +
vt8500/wm8x50 anyway so maybe it doesn't need to be rebased.

Let me know if I need to do anything (other than the -m to cleanup the
stats).

Regards
Tony P
