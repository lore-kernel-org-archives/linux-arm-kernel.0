From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Oct 2013 10:49:02 -0700
Subject: [GIT PULL] Fifth Round of Renesas ARM based SoC fixes for v3.12
In-Reply-To: <cover.1380874512.git.horms+renesas@verge.net.au>
References: <cover.1380874512.git.horms+renesas@verge.net.au>
Message-ID: <20131007174902.GB17592@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 05:19:40PM +0900, Simon Horman wrote:
> Hi Kevin, Olof and Arnd,
> 
> please consider this fifth Round of Renesas ARM based SoC fixes for v3.12.
> 
> This pull request is based on renesas-fixes4-for-v3.12 which you have
> already pulled.
> 
> 
> The following changes since commit 3786f86b60833f32e3eeb016fcf8c324f8147e00:
> 
>   ARM: shmobile: Remove #gpio-ranges-cells DT property (2013-09-22 21:28:18 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes5-for-v3.12

This doesn't look like a functional regression to me so I've pulled this
into next/cleanup for 3.13. Let me know if I've misunderstood and if it
causes issues on 3.12.


-Olof
