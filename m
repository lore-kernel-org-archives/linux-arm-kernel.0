From: avinashphilip@ti.com (Philip, Avinash)
Date: Wed, 26 Sep 2012 09:47:19 +0000
Subject: [PATCH v2] arm/dts: AM33XX: Add SPI device tree data
In-Reply-To: <1347946228-25874-1-git-send-email-avinashphilip@ti.com>
References: <1347946228-25874-1-git-send-email-avinashphilip@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3E9A927A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Tue, Sep 18, 2012 at 11:00:28, Philip, Avinash wrote:
> Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> as the driver) is reused from OMAP4.
> 	
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> Tested-by: Matt Porter <mporter@ti.com>


I haven't received any comments till now for this patch. 
Do you have any comments for this patch? 

With this patch SPI is working on AM335x SoC in PIO mode.

If no comments, can you pull this patch for 3.7?

Thanks
Avinash
