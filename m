From: avinashphilip@ti.com (Philip, Avinash)
Date: Mon, 5 Nov 2012 11:32:40 +0000
Subject: [PATCH v3] ARM: dts: AM33xx: Add SPI node
In-Reply-To: <50927DF5.4080008@ti.com>
References: <1351680669-20718-1-git-send-email-avinashphilip@ti.com>
 <50927DF5.4080008@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3E9DAB5F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2012 at 19:19:41, Cousson, Benoit wrote:
> Hi Avinash,
> 
> On 10/31/2012 11:51 AM, Philip, Avinash wrote:
> > Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> > as the driver) is reused from OMAP4.
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> > Tested-by: Matt Porter <mporter@ti.com>
> 
> I've just realized the interrupt-parent was still there, so I removed both.
> 
> Please find below the updated version.

I tested it and thanks for the fix.

Thanks
Avinash
