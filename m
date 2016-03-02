From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 21:50:59 +0100
Subject: [GIT PULL] at91: dt for 4.6 #2
In-Reply-To: <1456934722-7023-1-git-send-email-nicolas.ferre@atmel.com>
References: <1456934722-7023-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1634323.MskpPxvyZt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2016 17:05:22 Nicolas Ferre wrote:
> A second batch of DT updates for 4.6. This time it is based on 4.5-rc3 as one
> of the patches fixes an node that was changed during 4.5-rc phase. As I saw
> that your "next/dt" branches are based on 4.5-rc3, I thought it wouldn't be a
> problem.

Right, thanks for checking.

> Overall a pretty simple series with mainly node addition for the latest SoC
> and its Xplained board.
> The tag doesn't embed Alexandre's previous DT Pull-Request for 4.6 that was
> based on 4.5-rc1. I verified though that  it doesn't conflict with it during a
> merge.

Ok, that is good too. Pulled into next/dt now.

I see that your gpg key has expired last week, you may want to do something
about that, I think you can just update the date rather than creating a
new key.

	Arnd
