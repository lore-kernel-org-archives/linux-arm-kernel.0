From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 31 Jan 2013 16:25:26 +0000 (UTC)
Subject: [PATCH 3/4] ARM: OMAP2+: clock: DEFINE_STRUCT_CLK_FLAGS helper
In-Reply-To: <abe7aceb564b97ab00b88b13a9aac487363e01c1.1358871018.git.afzal@ti.com>
References: <cover.1358871018.git.afzal@ti.com>
 <abe7aceb564b97ab00b88b13a9aac487363e01c1.1358871018.git.afzal@ti.com>
Message-ID: <alpine.DEB.2.00.1301311625120.32145@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Jan 2013, Afzal Mohammed wrote:

> DEFINE_STRUCT_CLK does not have the capability to set flags, define
> DEFINE_STRUCT_CLK_FLAGS to handle flags. This is needed to add
> SET_RATE_PARENT flag in statically defined lcd clock in am335x.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

Thanks, queued for 3.9.


- Paul
