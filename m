From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 27 Jun 2012 06:53:57 +0000
Subject: [PATCH v4 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
In-Reply-To: <4FE9CDA8.40208@ti.com>
References: <cover.1340354985.git.afzal@ti.com>
 <7a14edf83068261d8c07217873d14fe7f73975bc.1340354986.git.afzal@ti.com>
 <4FE88DDE.60601@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99F002@DBDE01.ent.ti.com>
 <4FE9C98B.2020003@ti.com> <4FE9CDA8.40208@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99F8B7@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jun 26, 2012 at 20:26:40, Hunter, Jon wrote:
> On 06/26/2012 09:39 AM, Jon Hunter wrote:

> > a single global variable called onenand_flags for storing the current
> > state of sync_read, sync_write, vhf and hf. At least this would be only
> > one global instead of 4. Not a big deal.

V5 has been posted with above changes

> Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Thanks
Afzal
