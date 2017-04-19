From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 07:04:03 -0700
Subject: [GIT PULL] ARM: at91: soc for 4.12
In-Reply-To: <20170410165642.jt4bucl2zwk26orm@piout.net>
References: <20170410165642.jt4bucl2zwk26orm@piout.net>
Message-ID: <20170419140403.GM29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 06:56:42PM +0200, Alexandre Belloni wrote:
> Hi Arnd, Olof,
> 
> This is a huge cleanup of the PM code in order to prepare support for a
> new suspend mode on sama5d2.
> 
> Note that as discussed with Arnd, the first two patches are fixes that
> are already upstream since v4.11-rc4. The rest of the pull request
> depends on them.
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.12-soc
> 
> for you to fetch changes up to b32de9dd38fcf9063e993dcdd64cc64ad344d3ac:
> 
>   ARM: at91: move SoC detection to its own driver (2017-03-31 20:36:10 +0200)
> 
> ----------------------------------------------------------------
> SoC for 4.12:
> 
>  - huge PM cleanup
>  - Move SoC detection to its own driver

Thanks, merged!


-Olof
