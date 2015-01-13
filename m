From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 17:22:55 +0100
Subject: [PATCH] clocksource: sirf: remove unused variable
In-Reply-To: <CAGsJ_4xgF5y9GQ2roh1MYSrvm+_n+fyxsUiVCp4gm+igTbdWdQ@mail.gmail.com>
References: <1599190.ZYSE4SrQSK@wuerfel> <54B52B39.1000607@linaro.org>
 <CAGsJ_4xgF5y9GQ2roh1MYSrvm+_n+fyxsUiVCp4gm+igTbdWdQ@mail.gmail.com>
Message-ID: <8635006.m811OQopQd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 January 2015 23:24:24 Barry Song wrote:
> 
> yes, arnd. i also asked Daniel to apply "clocksource: marco: Rename
> marco to atlas7" rebased on this fix here:
> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/81428bbe1d8a073bb3741678ef1d3c1016119c77

Ok
 
> so this one is excluded from my pull request for atlas7. a
> pull-request from arm-soc might cause merge conflicts?

I was just doing build-tests on linux-next today and submitted patches
for each new warning or error I saw. Nothing to worry about as it's already
fixed and I'm dropping my version as soon as the other fix makes it into
next.

	Arnd
