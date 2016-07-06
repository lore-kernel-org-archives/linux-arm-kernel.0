From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Jul 2016 22:48:42 -0700
Subject: [GIT PULL 3/4] ARM: dts: exynos: MFC driver topic branch for
 v4.8, part 2
In-Reply-To: <1467273075-13747-4-git-send-email-k.kozlowski@samsung.com>
References: <1467273075-13747-1-git-send-email-k.kozlowski@samsung.com>
 <1467273075-13747-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160706054842.GO23212@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 09:51:14AM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Continuation of previous topic branch (tag tags/samsung-drivers-exynos-mfc-4.8).
> DTS changes only but this depends on previous work.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 96167bd37dd604cbba0aed341765dda8556405b2:
> 
>   ARM: dts: exynos: Enable MFC device on Exynos4412 Odroid boards (2016-06-06 09:30:43 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-exynos-mfc-4.8-2
> 
> for you to fetch changes up to 9f7d27fa1b0b3685471a1a34223a3475943f53e4:
> 
>   ARM: dts: exynos: enable MFC device for all boards (2016-06-08 09:46:00 +0200)
> 
> ----------------------------------------------------------------
> Topic branch for Exynos MFC changes for v4.8, part 2:
> 
> Replace hardcoded reserved memory ranges with auto-allocated ones
> and enable MFC for all boards.

Merged, thanks. Had a minor context conflict with previous DT contents.


-Olof
