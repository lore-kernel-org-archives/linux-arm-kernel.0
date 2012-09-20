From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Sep 2012 07:39:34 +0000
Subject: [PATCH v2 00/34] i.MX multi-platform support
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201209200739.34899.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 September 2012, Shawn Guo wrote:
> 
> Here is the second post, which should have addressed the comments that
> reviewers put on v1.
> 
> It's available on branch below.
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git imx/multi-platform-v2
> 
> And it's based on the following branches.
> 
>   calxeda/multi-plat
>   arm-soc/multiplatform/platform-data
>   arm-soc/multiplatform/smp_ops
>   arm-soc/imx/cleanup
>   arm-soc/imx/dt
>   sound/for-3.7
> 
> Subsystem maintainers,
> 
> I plan to send the whole series for 3.7 via arm-soc tree.  Please let
> me know if you have problem with that.  Thanks.

The first five branches are scheduled to go through the arm-soc tree, so
I'm fine with that. For the sound/for-3.7 branch, I'd like to know when
to expect that hitting mainline. If it always gets in very early during the
merge window, it's probably ok to put the imx/multi-platform patches into
the same branch as the other ones in arm-soc and wait for the sound stuff
to hit mainline first, otherwise I'd suggest we start a second
next/multiplatform-2 branch for imx and send the first part early on
but then wait with the second batch before sound gets in.

	Arnd
