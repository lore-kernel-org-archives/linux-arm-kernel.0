From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 23 Nov 2017 10:13:08 +0100
Subject: [PATCH 6/8] drm/mediatek: Add mfd support for mt8173
In-Reply-To: <20171114214114.15793-7-mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
 <20171114214114.15793-7-mbrugger@suse.com>
Message-ID: <1511428388.7685.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-11-14 at 22:41 +0100, Matthias Brugger wrote:
> Use the MFD device for SoC mt8173. Probing via devicetree
> is no longer needed for any SoC, so delete it.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Apart from the mmsys_private issue noted in previous patches,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
