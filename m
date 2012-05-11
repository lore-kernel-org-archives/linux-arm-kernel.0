From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 May 2012 00:52:48 -0700
Subject: [GIT PULL] arch/arm/mach-* late_initcall cleanup
In-Reply-To: <CAAQ0ZWQ75tYxbnCHXW-WtDVLyFcf9WdvX=5MBiAOXD+ONrU8-g@mail.gmail.com>
References: <CAAQ0ZWQ75tYxbnCHXW-WtDVLyFcf9WdvX=5MBiAOXD+ONrU8-g@mail.gmail.com>
Message-ID: <CAOesGMho9t9z1rm8Ja_82tuyUF3GrSOKfgeYdoQTC2y6gjC16w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, May 3, 2012 at 8:27 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Arnd, Olof,
>
> Please pull the arch/arm/mach-* late_initcall cleanup series below. ?I
> have collected acks from most of platform maintainers, and it may be
> the time to have them expose on linux-next to ensure they do not
> introduce any regression.

I've pulled this in as devel/cleanup-late-initcall in arm-soc and
keeping it as staging/cleanup (included in for-next). If we don't get
any reports of breakage in the next few days we'll move it over to
next/cleanup for the merge window.

It had a trivial merge conflict with the recent omap pull requests
that I resolved.


-Olof
