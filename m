From: olof@lixom.net (Olof Johansson)
Date: Tue, 16 Oct 2012 11:09:02 -0700
Subject: [GIT PULL] imx multi-platform support
In-Reply-To: <20121015034047.GB24393@S2101-09.ap.freescale.net>
References: <20121015034047.GB24393@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMiJhst7wnG-uBNbOH8dXELBzUsP1eXsm0iDU6p3_+07Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 14, 2012 at 8:40 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Arnd, Olof,
>
> Here is the imx multi-platform support [1] that missed 3.7 merge window.
> Please pull it for 3.8 and exposing on linux-next.  As it touches a lot
> of files, I send it early, so that people can base their works off it
> to avoid conflicts.

Thanks! I've pulled this into arm-soc under the next/cleanup branch,
since all but the last commit really is cleanup (moving around header
files) and I didn't see a need to split out the last commit in a
separate branch.

> Sascha, please base your 3.8 branches off this one.
>
> Subsystem maintainers,
>
> We will keep this topic branch stable (non-rebase), so you are free
> to merge it to solve conflicts or dependency if necessary.

As a note and reminder to others: please base your changes on the
imx/multiplatform branch in arm-soc, or on Shawn's own branch, not on
next/cleanup or the for-next branch of arm-soc.


Thanks!

-Olof
