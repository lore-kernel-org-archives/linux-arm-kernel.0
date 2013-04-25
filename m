From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Apr 2013 01:15:47 +0900
Subject: linux-next: manual merge of the arm-soc tree with the pm tree
In-Reply-To: <20130424165417.5e2b74a01728d307e454750f@canb.auug.org.au>
References: <20130424165417.5e2b74a01728d307e454750f@canb.auug.org.au>
Message-ID: <517956B3.2000201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/13 15:54, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-exynos/cpuidle.c between commit 554c06ba3ee2 ("cpuidle:
> remove en_core_tk_irqen flag") from the pm tree and commit 2eb89f893e44
> ("ARM: EXYNOS: factor out the idle states") from the arm-soc tree.
>
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Looks OK to me, thanks.

- Kukjin
