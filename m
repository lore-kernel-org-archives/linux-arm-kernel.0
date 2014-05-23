From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 18:14:47 +0200
Subject: [GIT PULL] at91: fixes for 3.15 #2
In-Reply-To: <1400780084-12085-1-git-send-email-nicolas.ferre@atmel.com>
References: <1400780084-12085-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201405231814.47539.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> Two more fixes for AT91 dealing with iio ADC triggers on
> at91sam9260/at91sam9g20. These fixes are not critical as the option is not
> widely used. But as they are pretty tiny, it might be interesting to include
> them now.
> 
> Thanks, best regards,
> 
> The following changes since commit 35d35aae817706800a4913711d563a99e1dc380a:
> 
>   dt-bindings: clock: Move at91.h to dt-bindigs/clock (2014-04-18 23:44:52 +0200)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes2
> 
> for you to fetch changes up to 13984e9bb15528f70059bbbbda3f9028157eebf6:
> 
>   ARM: at91: sam9260: fix compilation issues (2014-05-22 18:39:34 +0200)
> 
> ----------------------------------------------------------------
> Second 3.15 fixes for AT91
> - two fixes concerning iio ADC triggers for at91sam9260 and at91sam9g20
>   one for the "device" file, the other for the DT.

Pulled into fixes branch, thanks!

	Arnd
