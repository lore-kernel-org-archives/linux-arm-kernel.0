From: olof@lixom.net (Olof Johansson)
Date: Sat, 30 Jun 2012 15:26:13 -0700
Subject: [GIT PULL] imx fixes for v3.5-rc (part 2)
In-Reply-To: <20120628090927.GB22990@S2101-09.ap.freescale.net>
References: <20120611044359.GD2344@S2101-09.ap.freescale.net>
 <CAAQ0ZWQ1D38onzk0aMaCTEQ-NSyCgEEUNwK3PfWbE2VUSG2ckQ@mail.gmail.com>
 <20120628090927.GB22990@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMifAQ-LYVPzimE_p8BpO32bLx8ycObYDWcMuTWbOFw3NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 28, 2012 at 2:09 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Olof,
>
> On Mon, Jun 11, 2012 at 12:47:15PM +0800, Shawn Guo wrote:
>> Shawn Guo (2):
>>       ARM: imx6q: remove unneeded clkdev lookups
>
> We agreed that this one is actually a cleanup and can be held off
> until 3.6 ...
>
>>       ARM: imx6q: fix suspend regression caused by common clk migration
>
> ... but this is one is indeed a fix, which seems missed from your
> pull-request to Linus.

Hi,

Yes, given that the branch had contents that wasn't suitable for
3.5-rc I didn't pull it. In the past, most maintainers will rebuild
the branch and send a fresh pull request.

I cherry-picked the patch above into our fixes branch now -- it sounds
like that's what you expected me to do this time? In the future,
please do send a refreshed pull request in this situations if you
don't mind (or be explicit if you want me to cherry-pick).


Thanks,


-Olof
