From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Aug 2013 13:27:11 -0700
Subject: [GIT PULL] msm gpio fixes for 3.11
In-Reply-To: <1374876322-2222-1-git-send-email-davidb@codeaurora.org>
References: <1374876322-2222-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20130804202711.GC15602@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 03:05:22PM -0700, David Brown wrote:
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
> 
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-3.11-fix1
> 
> for you to fetch changes up to 8fd62389a778c902c7e8532594ea924bbaf465e8:
> 
>   ARM: msm: Consolidate gpiomux for older architectures (2013-07-26 14:55:38 -0700)
> 
> ----------------------------------------------------------------
> Fixes for MSM for 3.11
> 
> Two small fixes for MSM.
> 
> The first fixes the a gpio controller register address.  I didn't see
> any acks from the devicetree maintainers, so I've copied them on this
> pull request.  The change itself is minor, and just to the register
> address.
> 
> The second change removes the gpiomux V1 code from MSM.  This was
> breaking compilation for some of the targets.

I'm guessing the second breakage was nothing new, but who am I to turn away
code removal even during -rc. :)


Pulled.


-Olof
