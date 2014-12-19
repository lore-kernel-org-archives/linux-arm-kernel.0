From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Fri, 19 Dec 2014 23:59:33 +0100
Subject: [PATCHv4] INPUT: Route keyboard LEDs through the generic LEDs
 layer.
In-Reply-To: <20141219144641.3a549feb1ee5f2b9400f62cb@linux-foundation.org>
References: <20141210010214.GZ3074@type.youpi.perso.aquilenet.fr>
 <20141219144641.3a549feb1ee5f2b9400f62cb@linux-foundation.org>
Message-ID: <20141219225933.GD3049@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Morton, le Fri 19 Dec 2014 14:46:41 -0800, a ?crit :
> > Changed in this version:
> > - Use kcalloc instead of kzalloc
> > - to avoid any mutex order violation, defer LED update into a work callback.
> 
> Confused.  This patch is identical to the one that's presently in -mm.

Well, yes: I'm submitting the latest version of this patch to Dmitry,
i.e. including the fixes that happened in the -mm tree.

Samuel
