From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Feb 2014 01:43:24 -0800
Subject: [GIT PULL 00/12] Second Round of Renesas ARM Based SoC Updates
 for v3.15
In-Reply-To: <cover.1392277789.git.horms+renesas@verge.net.au>
References: <cover.1392277789.git.horms+renesas@verge.net.au>
Message-ID: <20140220094324.GR19089@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 05:04:56PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> please consider this second round of Renesas ARM Based SoC updates for v3.15.
> 
> This pull-request is based on the first round of such changes,
> tagged as renesas-soc-for-v3.15, which I have previously sent a
> pull-request for.
> 
> 
> The following changes since commit 012a7069b5a10a0851584d71a1facdc40a972319:
> 
>   ARM: shmobile: r8a7790: Add PCI USB host clock support (2014-02-04 10:25:03 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.15

Hi,

I'm stopping my merges for the night here, so I haven't merged this but I'll
likely do it tomorrow. I did have comments on one of the patches though (that
adds a new include/mach file that's not really needed). Fixing that can be done
incrementally though, especially if you have downstream users of this branch.


-Olof
