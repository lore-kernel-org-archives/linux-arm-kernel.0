From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Oct 2015 10:38:08 +0900
Subject: [PATCH v12 0/7] arm64: renesas: Add Renesas R8A7795 SoC support
In-Reply-To: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
References: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20151027013808.GA12057@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?, 10? 26, 2015 at 03:01:45?? +0900, Simon Horman wrote:
> Hi,
> 
> this patchset adds basic support for the Renesas R-Car H3 (R8A7795) SoC
> and its Saovator-X board.
> 
> 
> Based on a merge of:
> * v4.3-rc1
> * clk-shmobile-for-v4.4 branch of 
>   git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
>   This provides the bindings and includes for the new CPG driver.
>   These are queued up by the subsystem maintainer, Mike Turquette,
>   for v4.4.
> 
> Run-time dependencies:
> * The base
> * The new GPG driver
>   "[PATCH/RFC v4 0/5] clk: shmobile: Add new Renesas CPG/MSSR DT bindings"
>   and its dependencies. This may be found in the
>   topic/cpg-mssr-v4 branch of
>   git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
> 
> 
> For changes see per-patch changelogs.

The key change was to update to new CPG/MSSR bindings via Geert
Uytterhoeven.

Availability:

* This patchset is available in the topic/r8a7795-gpio-v2 branch of my
  renesas tree on kernel.org.
