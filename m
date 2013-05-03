From: airlied@gmail.com (Dave Airlie)
Date: Fri, 3 May 2013 15:40:25 +1000
Subject: [PATCH V2] video: implement a simple framebuffer driver
In-Reply-To: <517FAF0C.1060901@ti.com>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <517F7245.2050606@iki.fi> <201304301228.42245.arnd@arndb.de>
 <517FAF0C.1060901@ti.com>
Message-ID: <CAPM=9twuLZT=BaGrmE6fvsSXciitG383ZnghP0hOnSfNGq=A5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> I think it would be reasonable to have a restriction of only a single
> bootfb instance, so one could just use static global variables/funcs to
> manage the hand-over.
>
> All this, of course, presumes that nobody else than fbcon is using the
> fb. But I think it's also a reasonable restriction that the fb device is
> not used (mmapped) by anyone.
>

We already have this on x86, though the handover isn't great,

FBINFO_MISC_FIRMWARE flag, and the aperture tracking stuff.

Dave.
