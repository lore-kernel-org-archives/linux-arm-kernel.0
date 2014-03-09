From: olof@lixom.net (Olof Johansson)
Date: Sun, 9 Mar 2014 11:53:04 -0700
Subject: [GIT PULL]ARM: sirf: machine update for 3.15
In-Reply-To: <CAGsJ_4wcp-vTJH=xm-4HjqvTHY1Q0E8cbnTGTk6z72DmwNCy1w@mail.gmail.com>
References: <CAGsJ_4wcp-vTJH=xm-4HjqvTHY1Q0E8cbnTGTk6z72DmwNCy1w@mail.gmail.com>
Message-ID: <20140309185304.GK22881@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Wed, Mar 05, 2014 at 10:57:24AM +0800, Barry Song wrote:
> Hi Guys,
> 
> most of the below are some minor fixes for coding style. "ARM: prima2:
> move to generic reset controller driver framework"
> has been ready near 3.14 merge window, but it was late to merge in
> 3.14, so move this one to 3.15.

This would have been good to have in the tag! I ended up copying it in myself.

> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
> tags/sirf-soc-for-3.15
> 
> for you to fetch changes up to e7eda91f6323bd7dc85598c639f5e4709efc2309:
> 
>   ARM: prima2: move to generic reset controller driver framework
> (2014-03-05 10:33:47 +0800)
> 
> ----------------------------------------------------------------
> ARM: sirf: machine update for 3.15
> 
> Among them:
>   ARM: prima2: l2x0: fix checkpatch issues
>   ARM: prima2: platsmp: fix checkpatch issues
>   ARM: prima2: common: fix checkpatch issues
>   ARM: prima2: rtciobrg: fix the typo about license
>   ARM: prima2: staticize sirfsoc_init_late function
>   ARM: prima2: move to generic reset controller driver framework

While the above is already in the git merge --log text, so there's no need to
have it in the tag also.

Anyway, I've merged this into next/cleanup since that was what most of the
patches were about. Thanks!


-Olof
