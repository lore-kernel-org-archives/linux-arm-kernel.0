From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Aug 2015 09:12:30 -0700
Subject: [GIT PULL] ARM: mvebu: cleanup changes for v4.3
In-Reply-To: <55D748E0.3080004@free-electrons.com>
References: <55D748E0.3080004@free-electrons.com>
Message-ID: <20150821161230.GB14452@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 21, 2015 at 05:50:56PM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for fixes for mvebu for v4.2.
> I hope it is not too late, if it can't make ti for 4.2, then we
> will apply it on 4.3, anyway the bug is here since 3.18.

Given the longevity of the bug (i.e. not a recent regression) and the lateness
in the release cycle, I've decided to queue this up for the 4.3
next/fixes-non-critical branch instead. I.e. it'll be included in the next
merge window.

> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.2-1
> 
> for you to fetch changes up to 5be9fc23cdb42e1d383ecc8eae8a8ff70a752708:
> 
>   ARM: orion5x: fix legacy orion5x IRQ numbers (2015-08-21 17:33:08 +0200)

Merged, thanks!


-Olof
