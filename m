From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 May 2018 10:43:39 +0200
Subject: [PATCH 0/5] ARM: shmobile: rcar-gen2: Remove legacy SMP fallback
 code
In-Reply-To: <1526647734-1200-1-git-send-email-geert+renesas@glider.be>
References: <1526647734-1200-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20180522084338.dk62ibxyi4mwmtby@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 02:48:49PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> R-Car H2 and M2-W have been supporting SMP enablement from DT using the
> "renesas,apmu" enable-method since v4.8.  A legacy fallback was left in
> place for backwards compatibility with old DTBs.
> 
> This patch series removes the legacy SMP fallbacks for R-Car H2 and
> M2-W, and consolidates their support in the common R-Car Gen2 machine
> definition.
> 
> For testing, this series is available in the
> topic/rcar2-legacy-smp-removal-v1 branch of my renesas-drivers git
> repository at
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (5):
>   ARM: shmobile: r8a7790: Remove legacy SMP fallback code
>   ARM: shmobile: r8a7790: Use common R-Car Gen2 machine definition
>   ARM: shmobile: r8a7791: Remove legacy SMP fallback code
>   ARM: shmobile: r8a7791: Use common R-Car Gen2 machine definition
>   ARM: shmobile: Remove unused shmobile_smp_init_fallback_ops()

Thanks, applied for v4.19.
