From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 1 Jul 2016 08:01:39 +0200
Subject: [PATCH 1/3] clk: sunxi: Add a driver for the CCU
In-Reply-To: <20160630211635.GE5485@lukather>
References: <cover.1467135898.git.moinejf@free.fr>
 <a55dc5d1a9f02dc4d71d5c21064bffebe5a7b149.1467135898.git.moinejf@free.fr>
 <20160628204502.GG5550@lukather>
 <20160629101256.93895e6ff9184efa340f69dd@free.fr>
 <20160630211635.GE5485@lukather>
Message-ID: <20160701080139.6cfbb779b61ba4be9b09d362@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Jun 2016 23:16:35 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > - some fixed_factor clocks may have a gate.
> 
> Which ones?

I know only the "osc12M" in the A83T. It is used by the ehci1.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
