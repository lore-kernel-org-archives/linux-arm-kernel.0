From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Sep 2012 01:26:43 -0700
Subject: [alsa-devel] [PATCH v2 00/34] i.MX multi-platform support
In-Reply-To: <20120921080123.GM2450@S2101-09.ap.freescale.net>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
 <20120920145342.GI2450@S2101-09.ap.freescale.net>
 <201209201556.57171.arnd@arndb.de>
 <20120921080123.GM2450@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMi6CbvFikycJVdE8W-DxLD3W7+CyScz+YT103dxR31U9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 1:01 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Sep 20, 2012 at 03:56:56PM +0000, Arnd Bergmann wrote:
>> Ok, fair enough. I think we can put it in arm-soc/for-next as a staging
>> branch anyway to give it some exposure to linux-next, and then we can
>> decide whether a rebase is necessary before sending it to Linus.
>>
> I just saw the announcement from Olof - no more major merge for 3.7
> will be accepted from now on.  Can this be an exception or should I
> plan this for 3.8?


I'll take a look at merging it tomorrow after I've dealt with smp_ops;
if it looks reasonably conflict-free I'll pull it in. We need the
sound dependency sorted out (or agreed upon) first though.


-Olof
