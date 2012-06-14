From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 14 Jun 2012 07:03:02 +0000
Subject: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <4FD8A906.8080202@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <4FD8A906.8080202@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jun 13, 2012 at 20:21:50, Hunter, Jon wrote:
 
> If the clk handle for the gpmc is passed to the gpmc driver, then there
> is no reason why the driver cannot do this.

I believe passing clk details through platform data is an abuse of
clock framework.

Regards
Afzal
