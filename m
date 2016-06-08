From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 8 Jun 2016 07:13:13 +0000
Subject: [PATCH 14/30] ARM: dts: r8a7790: Fix W=1 dtc warnings
In-Reply-To: <2c3de36700d4f3a5da1eb67e9340bfccfce19fdb.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
 <2c3de36700d4f3a5da1eb67e9340bfccfce19fdb.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <871t48jh1e.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Warning (unit_address_vs_reg): Node /cache-controller at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /cache-controller at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,dvc/dvc at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,dvc/dvc at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,mix/mix at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,mix/mix at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 2 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 3 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 4 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 5 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 6 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ctu/ctu at 7 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 2 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 3 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 4 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 5 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 6 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 7 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 8 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,src/src at 9 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 2 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 3 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 4 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 5 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 6 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 7 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 8 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /sound at ec500000/rcar_sound,ssi/ssi at 9 has a unit name, but no reg property
> 
> Move the cache-controller nodes under the cpus node, and make their unit
> names and reg properties match the MPIDR values.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---

For sound portion.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
