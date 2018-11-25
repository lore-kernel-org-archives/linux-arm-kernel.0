From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 21:10:51 -0200
Subject: [PATCH 02/13] ARM: multi_v7_defconfig: Add missing systemd options
In-Reply-To: <CAOesGMjR--5XC1pNMkPHR9BaPfgGfdC8JHAM3oqS3Xte3TQbGA@mail.gmail.com>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-2-otavio@ossystems.com.br>
 <CAOesGMjR--5XC1pNMkPHR9BaPfgGfdC8JHAM3oqS3Xte3TQbGA@mail.gmail.com>
Message-ID: <CAP9ODKrTZm8FuRWLh+5NZSbpMh_yptotdoEgfrARHypUx8FkMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

On Sun, Nov 25, 2018 at 8:25 PM Olof Johansson <olof@lixom.net> wrote:
> Thanks for these patches. I don't have a reason to _not_ enable
> systemd features, but would you mind providing a brief description of
> what's not working without this change? Is it completely broken, or is
> it just the random-UID featues that don't work, or something else?.
> Useful for others to know what's expected to break if someone turns
> them off, etc.

Thank you for your kindness reviewing this. I am not an experienced
Linux kernel contributor so I am going to do some mistakes during this
process.

We usually follow the required feature set listed on Gentoo wiki[1] as
it is usually up to date and avoids a lot of headaches for us when
dealing with boot issues with SystemD.

1. https://wiki.gentoo.org/wiki/Systemd#Kernel

Do you think mentioning where it has been taken from is enough?

> Also, I noticed you posted a series of 13 patches, which includes some
> dts files for rv1108, some network driver changes and some of these
> more generic defconfig changes. I would suggest that you split up your
> patches into independent series where possible, especially when they
> end up going to different subsystems. Providing suitable cover letters
> for the series when you post them is also useful to help reviewers by
> summarizing the series, including changes from last time it was
> posted, etc. Please address it to the superset of patch receivers on
> the series.

I can certainly improve it for the next submission. Should I split
them all and tag them v2 to easy it?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
