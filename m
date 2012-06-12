From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 12 Jun 2012 07:16:26 +0000
Subject: [PATCH v5 04/14] ARM: OMAP2+: gpmc: minimal driver support
In-Reply-To: <4FD6586A.9060706@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <54e643eb1b4dbefcbb52580fa582043bf4f0da3d.1339419492.git.afzal@ti.com>
 <4FD6586A.9060706@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E997E2A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jun 12, 2012 at 02:13:22, Hunter, Jon wrote:

> > +	gpmc_revision = (l >> 4) & 0xf;
> 
> Why are you only storing the major part of the rev? Why not keep both parts?

Does having minor revision add any value ?, at least as of now,
I do not see any.

> 
> > +	dev_info(gpmc_dev, "GPMC revision %d.%d\n", gpmc_revision, l & 0x0f);
> 
> Nit-pick, please add a mask and shift definition for the revision
> register major and minor fields and use these above.

Yes, right

Regards
Afzal
