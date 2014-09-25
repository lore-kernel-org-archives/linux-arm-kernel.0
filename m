From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 18:05:17 +0200
Subject: [GIT PULL v2][for v3.18] pull request from pxa git
In-Reply-To: <CAD6h2NQN9JSOVmzYuTM8201011nmyG=hxOjwibr4kOLt7b_-iQ@mail.gmail.com>
References: <CAD6h2NQN9JSOVmzYuTM8201011nmyG=hxOjwibr4kOLt7b_-iQ@mail.gmail.com>
Message-ID: <201409251805.17767.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 September 2014, Haojian Zhuang wrote:
> ----------------------------------------------------------------
> Since DT aren't fully enabled in pxa2xx, it's fine to merge them in v3.18
> 
> ----------------------------------------------------------------
> Daniel Mack (2):
>       ARM: pxa: dts: fix mmc controller compatible string
>       ARM: pxa: dts: fix ohci controller compatible string
> 

Pulled into next/dt, thanks!

In the tag description, it would be nice to have a one-line statement the
same way you do for the individual commits, I used "pxa2xx DT changes"
this time.

	Arnd
