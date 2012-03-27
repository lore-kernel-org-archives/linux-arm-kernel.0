From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 27 Mar 2012 05:38:58 +0000
Subject: [TMP][PATCH 5/5] OMAP3EVM: Test gpmc-nand
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317BD700@DBDE01.ent.ti.com>
References: <1332484630-22181-1-git-send-email-afzal@ti.com>
 <4F70ACB6.5070208@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317BD700@DBDE01.ent.ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317BD76F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Mar 27, 2012 at 10:49:32, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Mon, Mar 26, 2012 at 23:21:50, Hunter, Jon wrote:
> > I see this is marked as a temp patch, but this is actually needed to 
> > register the device. Actually, we would need to do this for all boards, 
> > right?
> 
> Yes, as NAND support on OMAP3EVM was not in mainline, made it TMP.
> Once GPMC driver interfaces are acceptable, other boards too will
> be modified accordingly.

Forgot to add that this patch was meant for testing and as the way
platforms deal with GPMC may change, this was kept as TMP for now.

Regards
Afzal
