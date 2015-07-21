From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Jul 2015 14:05:42 -0700
Subject: [GIT PULL] Samsung 1st fixes for v4.2
In-Reply-To: <55ADBF14.30304@kernel.org>
References: <55ADBF14.30304@kernel.org>
Message-ID: <20150721210542.GA13353@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Tue, Jul 21, 2015 at 12:40:04PM +0900, Kukjin Kim wrote:
> Hi,
> 
> Please pull samsung fixes for v4.2.
> 
> Thanks,
> Kukjin
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-fixes-1
> 
> for you to fetch changes up to 300bde79f3d86b1af6fcde7b7b2439ecffccbff4:
> 
>   ARM: dts: add CPU OPP and regulator supply property for exynos4210
> (2015-07-21 12:32:29 +0900)

Was there a reason you rebased Krzystztof's branch? The contents is identical.

In cases like those, feel free to just forward the pull request to us
and we can do it directly. If you have more patches you want to add into
the same fixes branch then you can just merge his in and apply yours on
top. That's for example how Tony Lindgren tends to handle OMAP -- he'll
forward a pull request from Paul Walmsley if that's the only contents
he has.

Anyway, merged.


-Olof
