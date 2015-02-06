From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Feb 2015 01:05:57 -0800
Subject: [GIT PULL 2/3] Samsung 4th DT updates for v3.20
In-Reply-To: <54D22D45.2090000@kernel.org>
References: <54D22D45.2090000@kernel.org>
Message-ID: <20150206090557.GK23582@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 11:31:33PM +0900, Kukjin Kim wrote:
> Hi,
> 
> Here is 4th DT updates for v3.20.
> Please pull.
> 
> Note there are several dt updates in my tree which has a dependency with
> driver side for v3.20 and I hope it can be sent to upstream via arm-soc
> during late merge window. If it is OK to you guys, I'll send a pull
> request soon. (example tmu, asoc and devfreq)

Why do they have driver dependencies? Can't the dts contents be merged
separately, such that the drivers just work once they land?

Or are you redefining bindings in an incompatible manner?

> The following changes since commit ea08de16eb1ba2052ce2db4b58b62a2ec33357a3:
> 
>   ARM: dts: Add DISP1 power domain for exynos5420 (2015-01-29 08:52:23
> +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dt-4
> 
> for you to fetch changes up to 7808cae3e97140781eb3f712084caf4e44c126c9:
> 
>   ARM: dts: Add PPMU node for exynos4412-trats2 (2015-02-04 08:11:52 +0900)


Merged.


-Olof
