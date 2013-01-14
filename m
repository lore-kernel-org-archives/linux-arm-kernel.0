From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 Jan 2013 14:16:38 -0800
Subject: [GIT PULL] timer: vt8500: Move timer code to drivers/clocksource
In-Reply-To: <1358140171-25390-1-git-send-email-linux@prisktech.co.nz>
References: <1358140171-25390-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130114221638.GA28091@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 06:09:30PM +1300, Tony Prisk wrote:
> Hi Olof,
> 
> Not sure if I have done this correctly but this is the patch to move the
> vt8500/timer.c code into drivers/clocksource.
> 
> I based it on timer/cleanup from armsoc (hopefully this is right - if not, a
> few pointers in the right direction would be appreciated).
> 
> Regards
> Tony P
> 
> 
> The following changes since commit 1c2584c3a1c882fec729147a46d822522552e38c:
> 
>   ARM: sunxi: fix struct sys_timer removal (2013-01-08 10:50:43 -0800)
> 
> are available in the git repository at:
> 
>   git://server.prisktech.co.nz/git/linuxwmt.git tags/vt8500/timer

Thanks, pulled and merged into next/cleanup.


-Olof
