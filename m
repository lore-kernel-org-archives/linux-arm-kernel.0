From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 12 Nov 2011 07:19:56 +0800
Subject: [PATCH 1/1] ASoC: mxs-saif: remove function in platform_data
In-Reply-To: <20111111150422.GX16886@pengutronix.de>
References: <1321003740-10992-1-git-send-email-b29396@freescale.com>
 <20111111150422.GX16886@pengutronix.de>
Message-ID: <20111111231955.GB9471@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 04:04:22PM +0100, Sascha Hauer wrote:
> On Fri, Nov 11, 2011 at 05:29:00PM +0800, Dong Aisheng wrote:
> > Add master_mode and master_id in platfrom_data since it's board
> > specific and board knows it.
> > Then we can remove the function pointer in platfrom_data to make
> > the driver more devicetree friendly.
> 
> Looks ok. Marc,

You meant Mark?

> is it ok when I take this patch? The SoC specific stuff
> for this patch depends on it.
> 
I thought I will start collecting mxs patches after v3.2-rc1.
Do you plan to collect mxs patches for one more cycle?

-- 
Regards,
Shawn
