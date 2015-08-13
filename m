From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 11:58:41 +0200
Subject: [GIT PULL] at91: dt for 4.3 #2
In-Reply-To: <20150807154544.GA18934@piout.net>
References: <20150807154544.GA18934@piout.net>
Message-ID: <20150813095841.GK30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 05:45:44PM +0200, Alexandre Belloni wrote:
> 
> Arnd, Olof, Kevin,
> 
> This is the second batch of DT changes for 4.3.
> It is mainly some preparation to support properly getting the slow clock
> from each driver so that the dtsis are ready when the driver change
> lands in each subsystem.
> 
> It also adds support for the lcd controller on at91sam9x5 and
> at91sam9n12. The driver changes have been submitted but didn't yet land
> in the drm and mfd subsystem however, I don't expect any issue getting
> those in.
> 
> Thanks, best regards,
> 
> The following changes since commit 22b5a0f7bc07ac4b4e4aab9a7f8cf2521819c1c4:
> 
>   ARM: at91/dt: add minimal sama5d2 Xplained board (2015-07-30 18:44:44 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-dt2
> 
> for you to fetch changes up to 761c5867ef031fae244d030bc17c93f5a3df106f:
> 
>   ARM: at91/dt: sama5d2: use slow clock where necessary (2015-08-07 17:33:54 +0200)

Merged, thanks!


-Olof
