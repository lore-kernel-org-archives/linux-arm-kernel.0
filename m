From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 May 2016 17:02:39 +0200
Subject: next-20160503 build: 1 failures 12 warnings (next-20160503)
In-Reply-To: <20160503141723.GR6292@sirena.org.uk>
References: <E1axZpG-000664-AK@optimist> <20160503141723.GR6292@sirena.org.uk>
Message-ID: <2280495.M9rYajvqUJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 May 2016 15:17:23 Mark Brown wrote:
> On Tue, May 03, 2016 at 01:53:18PM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an ARM allmodconfig due to:
> 
> >       arm-allmodconfig
> > ../drivers/pinctrl/bcm/pinctrl-ns2-mux.c:540:17: error: 'pinctrl_utils_dt_free_map' undeclared here (not in a function)
> 
> caused by b5aa1006e4a93 (pinctrl: ns2: add pinmux driver support for
> Broadcom NS2 SoC) - presumably just a missing dependency.
> 

No, the function got renamed in another patch. I already prepared a fix
yesterday, but haven't gotten around to submit the patches for the last
two days, I'll try to send it out today, but it might end up being
tomorrow, or Linus could fix this one himself first.

	Arnd
