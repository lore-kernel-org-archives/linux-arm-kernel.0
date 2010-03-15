From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 15 Mar 2010 17:16:33 +0100
Subject: [RFC/PATCH] ARM: add Tegra support
In-Reply-To: <20100315065420.GA29639@avionic-design.de>
References: <4B96798C.6060201@compulab.co.il> <4B9C8768.3050400@compulab.co.il>
	<20100315065420.GA29639@avionic-design.de>
Message-ID: <20100315161633.GA13119@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thierry Reding wrote:
> * Mike Rapoport wrote:
> > Mike Rapoport wrote:
> > >This patch adds basic support for Nvidia Tegra2 platform.
> > >
> > > From 13fac106b9383478a3337e443a946286998536d7 Mon Sep 17 00:00:00 2001
> > >From: Mike Rapoport <mike@compulab.co.il>
> > >Date: Tue, 9 Mar 2010 18:35:45 +0200
> > >Subject: [PATCH] ARM: add Tegra support
> > >
> > >Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> > >---
> > 
> > Any comments on this?
> 
> I like it. I will try to get around to test this today.

So this seems to work well. I'm able to boot a kernel built with this patch
and run a basic initial ramdisk. Do you have any kind of roadmap of what you
are currently working on? I'd rather not duplicate any work you're already
doing.

Thierry
