From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Nov 2012 12:20:21 +0000
Subject: [GIT PULL]: spear-for-3.8 (was earlier: Re: [PATCH 00/14] ARM:
 SPEAr: DT updates)
In-Reply-To: <CAKohpokP60SXv02r8kETRLSf+RviFB8bgpO-VNvTfetQG4AtOA@mail.gmail.com>
References: <CAKohpokP60SXv02r8kETRLSf+RviFB8bgpO-VNvTfetQG4AtOA@mail.gmail.com>
Message-ID: <201211261220.21648.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 November 2012, Viresh Kumar wrote:
> On 22 November 2012 01:54, Olof Johansson <olof@lixom.net> wrote:
> 
> > We're also running out of time for 3.8 staging, but if you're able to
> > figure out the above I'll make an attempt to apply the patches from above.
> 
> Hi Arnd/Olof,
> 
> To make things easy for you, i have a PULL request for you now :)
> 
> The following changes since commit 53d74fd79db19aae506de892273198b160c2ee95:
> 
>   Merge commit 'gpio-lw/devel' into spear-for-3.8 (2012-11-26 15:48:53 +0530)
> 
> are available in the git repository at:
> 
> 
>   git://git.linaro.org/people/vireshk/linux.git spear-for-3.8
> 
> for you to fetch changes up to df1590d9ae5e37e07e7cf91107e4c2c946ce8bf4:
> 
>   ARM: SPEAr3xx: Shirq: Move shirq controller out of plat/ (2012-11-26
> 16:55:33 +0530)

Since Olof has done more than his share of the work for today, I've pulled
it in now, into next/dt2 rather than next/dt because of the dependencies.

We already had the gpio dependency in arm-soc, but the pinctrl dependency
is slightly newer than the one we had, so I added a second
depends/pinctrl-devel2 branch based on 4ddb1c2.

	Arnd
