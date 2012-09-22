From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 22 Sep 2012 11:43:03 -0400
Subject: [alsa-devel] [PATCH v2 00/34] i.MX multi-platform support
In-Reply-To: <CAOesGMi6CbvFikycJVdE8W-DxLD3W7+CyScz+YT103dxR31U9g@mail.gmail.com>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
 <20120920145342.GI2450@S2101-09.ap.freescale.net>
 <201209201556.57171.arnd@arndb.de>
 <20120921080123.GM2450@S2101-09.ap.freescale.net>
 <CAOesGMi6CbvFikycJVdE8W-DxLD3W7+CyScz+YT103dxR31U9g@mail.gmail.com>
Message-ID: <20120922154303.GO4495@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 01:26:43AM -0700, Olof Johansson wrote:

> I'll take a look at merging it tomorrow after I've dealt with smp_ops;
> if it looks reasonably conflict-free I'll pull it in. We need the
> sound dependency sorted out (or agreed upon) first though.

I guess in the light of the rest of the thread it doesn't much matter
for this merge window but I just pushed:

 git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.7

which is signed so can happily be merged elsewhere.
