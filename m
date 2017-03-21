From: tj@kernel.org (Tejun Heo)
Date: Tue, 21 Mar 2017 12:56:50 -0400
Subject: [PATCH v2 0/3] ATA/ARM: convert ARM/DaVinci to use libata PATA
 drivers
In-Reply-To: <3c115ec1-2d11-695e-eca7-25a75f71b96f@ti.com>
References: <CGME20170314163738epcas5p3db719229d59550476c918a15d8c16d63@epcas5p3.samsung.com>
 <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
 <20170316213255.GF1480@htj.duckdns.org>
 <3c115ec1-2d11-695e-eca7-25a75f71b96f@ti.com>
Message-ID: <20170321165650.GA3706@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 21, 2017 at 02:08:26PM +0530, Sekhar Nori wrote:
> > Looks fine to me from libata side.  Once it gets tested, how should
> > the patches be routed?  I don't think it'd make sense to route them
> > separately.
> 
> Hi Tejun, I can take the series through ARM-SoC tree with your ack.

Once the review points are addressed, please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

and route through the arm tree.

Thanks.

-- 
tejun
