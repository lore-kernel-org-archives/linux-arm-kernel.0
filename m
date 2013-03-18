From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:20:52 +0900
Subject: [GIT PULL] Renesas INTC External IRQ pin driver
In-Reply-To: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
References: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130318122052.GA27503@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 09:05:44PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> The following changes since commit da8288d03cd9e22036c759c1bfb5ec91e4ad01fd:
> 
>   ARM: shmobile: fix kzm9g-reference compile breakage (2013-03-14 00:00:14 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-intc-external-irq-for-v3.10
> 
> for you to fetch changes up to 2033e618f13f8efc782b9ad511dd37b654943072:
> 
>   irqchip: irqc: Add DT support (2013-03-14 00:02:46 +0900)
> 
> ----------------------------------------------------------------
> Renesas INTC External IRQ pin driver
> 
> This provides two new INTC drivers for use with Renesas ARM-based SoCs and
> makes use of them on the r8a7779 and sh73a0 SoCs.
> 
> It has been agreed by the relevant parties, Thomas Gleixner, Magnus Damm,
> and myself that it would be best to merge this code through the renesas
> tree and thus through the arm-soc tree.
> 
> This is based on:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc-v3.10

It seems there is a problem with renesas-soc-for-v3.10 so please
ignore this pull request.
