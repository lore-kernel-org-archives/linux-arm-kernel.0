From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Sat, 22 Jul 2017 08:42:11 +0200
Subject: [PATCH v2] media: Convert to using %pOF instead of full_name
In-Reply-To: <20170721192835.25555-2-robh@kernel.org>
References: <20170721192835.25555-1-robh@kernel.org>
 <CGME20170721192855epcas5p40919807b161c8dee900b5661ea5128aa@epcas5p4.samsung.com>
 <20170721192835.25555-2-robh@kernel.org>
Message-ID: <97f42d10-d2ed-c5bb-9562-5515d5f13f7d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2017 09:28 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring<robh@kernel.org>
> Acked-by: Niklas S?derlund<niklas.soderlund+renesas@ragnatech.se>
> Acked-by: Laurent Pinchart<laurent.pinchart@ideasonboard.com>
> Reviewed-by: Matthias Brugger<matthias.bgg@gmail.com>
> Acked-by: Nicolas Ferre<nicolas.ferre@microchip.com>
> Acked-by: Lad, Prabhakar<prabhakar.csengg@gmail.com>

> ---
> v2:
> - Fix missing to_of_node() in xilinx-vipp.c
> - Drop v4l2-async.c changes. Doing as revert instead.
> - Add acks

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
