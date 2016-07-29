From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 29 Jul 2016 07:56:08 +0200
Subject: [PATCH] regulator: axp20x: support AXP813 variant
In-Reply-To: <20160728201944.GH6682@lukather>
References: <20160728095531.81F5D441@mail.free-electrons.com>
 <20160728201944.GH6682@lukather>
Message-ID: <20160729075608.d87c520483cd7b054a001ce5@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jul 2016 22:19:44 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> >  Documentation/devicetree/bindings/mfd/axp20x.txt | 32 ++++++++-
> >  drivers/mfd/axp20x-rsb.c                         |  1 +
> >  drivers/mfd/axp20x.c                             |  3 +
> >  drivers/regulator/axp20x-regulator.c             | 82 +++++++++++++++++++++++-
> >  include/linux/mfd/axp20x.h                       | 38 +++++++++++
> >  5 files changed, 153 insertions(+), 3 deletions(-)
> 
> And this needs to be split per logical changes.

There is only one logical change: support the AXP813.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
