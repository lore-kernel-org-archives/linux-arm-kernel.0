From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Nov 2012 12:31:22 +0000
Subject: [GIT PULL v3] ST-Ericsson Device Tree patches
In-Reply-To: <20121127111540.GC2013@gmail.com>
References: <20121120162836.GE28265@gmail.com>
 <20121127111540.GC2013@gmail.com>
Message-ID: <201211271231.23121.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 November 2012, Lee Jones wrote:
> The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:
> 
>   Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/ljones/linux-3.0-ux500.git ste-dt-for-next
> 
> for you to fetch changes up to e13316d60658aee7987b51025f342649baa33487:
> 
>   ARM: ux500: Rename dbx500 cpufreq code to be more generic (2012-11-27 10:58:57 +0000)

Pulled into next/dt and updated the ux500/dt branch to the latest head. Thanks!

Olof, just to clarify: there are 43 patches listed in the pull request, but there
are actually just 5 patches that were not there before. As discussed with Lee on
#linaro-kernel, this fixes a long-standing build error in for-next u8500_defconfig,
but does not fix the problem of a couple of duplicate patch IDs that still have in
the ux500/dt branch. I could not come up with a way that would actually improve
the situation rather than introduce other problems.

	Arnd
