From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Sep 2012 22:05:31 -0700
Subject: [PATCH 4/4] ARM: ks8695: convert to generic time and clocksource
In-Reply-To: <CAFumwP28D-ijJtBpQ39qDXkimMx-ucvwgS6jG3jdQ+DoYpgx9w@mail.gmail.com>
References: <1346264842-20411-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdab72Z86i21TNohS0YO=Bav7eQgHwQyXa0tXQB=0hhgAg@mail.gmail.com>
 <5044A954.4000706@snapgear.com> <201209031324.22877.arnd@arndb.de>
 <CAFumwP28D-ijJtBpQ39qDXkimMx-ucvwgS6jG3jdQ+DoYpgx9w@mail.gmail.com>
Message-ID: <20120905050531.GE6747@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 04:55:41PM +0200, Andrew Victor wrote:
> hi,
> 
> On Mon, Sep 3, 2012 at 3:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 03 September 2012, Greg Ungerer wrote:
> >> > I suspect
> >> > some of these platforms may have more users than we
> >> > believe.
> >>
> >> I know the guys at www.opengear.com are still building hardware around
> >> the KS8695. And they update to modern kernels from time to time. So its
> >> not completely obsolete yet. I have some SnapGear boards based around it
> >> too, though they went out of production about 2 years ago.
> >
> > Ok, good to know. Maybe we can catch their interest with this mail thread
> > here and get them to contribute upstream as well.
> 
> 
> Vision System GmbH are (or were) also using the KS8695.

Ok, cool. Definitely not a candidate for removal based on what we've
seen then.

I would like to consolidate some of the defconfigs though, since
there are currently three of them and the platform supports multi-board
kernels. Anyone objecting to moving over to ks8695_defconfig as a superset
of the current three ones (acs5k{,_tiny}_defconfigs)? I'll post a patch
to NAK tomorrow. :)


-Olof
