From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Mar 2017 17:37:50 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.12
In-Reply-To: <cover.1490000158.git.horms+renesas@verge.net.au>
References: <cover.1490000158.git.horms+renesas@verge.net.au>
Message-ID: <20170322003750.GI5129@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 09:58:23AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC drivers updates for v4.12.
> 
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v4.12
> 
> for you to fetch changes up to cd59de80dd34dd2d1a3ca97d7a6e712c048b135a:
> 
>   soc: renesas: Identify RZ/G1N (2017-03-13 10:26:08 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Drivers Updates for v4.12
> 
> * Identify RZ/G1N and RZ/G1H
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (2):
>       soc: renesas: Identify RZ/G1H
>       soc: renesas: Identify RZ/G1N

At first I was wondering why you'd applied the same patch twice. Renesas likes
to make names similar *and* hard to remember sometimes. :-)


-Olof
