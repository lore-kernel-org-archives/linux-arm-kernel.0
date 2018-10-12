From: olof@lixom.net (Olof Johansson)
Date: Fri, 12 Oct 2018 11:12:34 -0700
Subject: [GIT PULL 3/4] ARM: exynos: soc/mach for v4.20, second round
In-Reply-To: <CAK8P3a2+wyge4=eCxJps0Ar3bYFrqjvdMakiYHBPmn3p63+GDg@mail.gmail.com>
References: <20181010182558.7034-1-krzk@kernel.org>
 <20181010182558.7034-4-krzk@kernel.org>
 <CAK8P3a2+wyge4=eCxJps0Ar3bYFrqjvdMakiYHBPmn3p63+GDg@mail.gmail.com>
Message-ID: <CAOesGMj2m9pOsDhY92Q-ycbCQXViHatrk-SvqO+TqdzDw7DJZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2018 at 7:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 10/10/18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Hi,
> >
> > On top of previous pull request.
> >
> > ----------------------------------------------------------------
> > Samsung mach/soc changes for v4.20, second round
> >
> > 1. Disable SAMSUNG_PM_CHECK Kconfig feature incompatible with Exynos.
> >
>
> I suspect Olof made a small mistake when he pulled the previous branch
> into next/dt instead of next/soc, so I ended up pulling the new branch
> with all commits into next/soc again.
>
> Nothing harmful happened and you did everything right, I was just
> a bit confused by this.

Indeed, thanks for catching that.


-Olof
