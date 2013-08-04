From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Aug 2013 12:21:33 -0700
Subject: [GIT 0/7] Renesas ARM and SH based SoC backlight drivers for v3.12
In-Reply-To: <cover.1374207161.git.horms+renesas@verge.net.au>
References: <cover.1374207161.git.horms+renesas@verge.net.au>
Message-ID: <20130804192133.GD10876@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 19, 2013 at 01:34:48PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following backlight drivers for v3.12.
> 
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
> 
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-backlight-for-v3.12

Pulled. In the future a branch like this could be split into the driver updates
for the backlight stuff, then board patches to plumb in the new drivers. But
I've pulled it all into the next/boards branch for now.


-Olof
