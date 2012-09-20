From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Sep 2012 07:41:50 -0400
Subject: [PATCH v2 00/34] i.MX multi-platform support
In-Reply-To: <201209200739.34899.arnd@arndb.de>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
Message-ID: <20120920114148.GH17666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 07:39:34AM +0000, Arnd Bergmann wrote:

> The first five branches are scheduled to go through the arm-soc tree, so
> I'm fine with that. For the sound/for-3.7 branch, I'd like to know when
> to expect that hitting mainline. If it always gets in very early during the
> merge window, it's probably ok to put the imx/multi-platform patches into
> the same branch as the other ones in arm-soc and wait for the sound stuff
> to hit mainline first, otherwise I'd suggest we start a second
> next/multiplatform-2 branch for imx and send the first part early on
> but then wait with the second batch before sound gets in.

It's usually pretty early but Takashi will be on holiday this time so
I'm not sure if things might be different (he was going to send the pull
request from holiday).  I also didn't guarantee that it'll be stable
yet, can someone please tell me what the depenency is here?
