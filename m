From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Oct 2013 14:49:38 -0700
Subject: [GIT PULL 4/4] omap late device tree changes for v3.13 merge
 window
In-Reply-To: <5267df07.41abe00a.6620.ffffb906SMTPIN_ADDED_MISSING@mx.google.com>
References: <pull-1382539003-174282>
 <5267df07.41abe00a.6620.ffffb906SMTPIN_ADDED_MISSING@mx.google.com>
Message-ID: <20131028214938.GH4802@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 07:36:43AM -0700, Tony Lindgren wrote:
> The following changes since commit c49f4984fd45be36502e903e7a5a6a4faff42931:
> 
>   Merge tag 'for_3.13/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.13/dt (2013-10-11 15:40:07 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/dt-late
> 
> for you to fetch changes up to b4887e16375be312cf64642ac1d826186cb836bf:
> 
>   Merge tag 'for_3.13_super_late/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.13/dt (2013-10-23 03:12:45 -0700)
> 


Pulled into next/dt.

By the way, I don't think it'll scale very well if we add MAINTAINERS entries
for all board port dts files, but I also don't know of a good way to make sure
that the people who care about those dts files get notified on patches
otherwise.


-Olof
