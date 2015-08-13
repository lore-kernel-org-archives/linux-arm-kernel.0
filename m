From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 12:02:51 +0200
Subject: [GIT PULL] ARM: mvebu: soc changes for v4.3 #2
In-Reply-To: <55C4D665.8060702@free-electrons.com>
References: <55C4D665.8060702@free-electrons.com>
Message-ID: <20150813100251.GM30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 07, 2015 at 06:01:41PM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the second pull request for soc for mvebu for v4.3
> 
> Gregory
> 
> The following changes since commit 482d638f98cc626bf01d4c9f6d6d35fc77d630c8:
> 
>   ARM: mvebu: Warn about the wake-up sources not taken into account in suspend (2015-07-28 11:40:47 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.3-2
> 
> for you to fetch changes up to 44e259ac909f3b41786cf732a44b5cf8444e098a:
> 
>   ARM: dove: create a proper PMU driver for power domains, PMU IRQs and resets (2015-08-05 18:36:49 +0200)

I've merged this into next/drivers (which now has a dependency on next/soc
since your branch was based on previous soc contents, but that's OK).

Thanks,

-Olof
