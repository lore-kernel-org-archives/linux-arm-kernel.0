From: liguo.zhang@mediatek.com (liguo zhang)
Date: Mon, 07 Mar 2016 07:26:32 -0000
Subject: [PATCH 1/2] Document: i2c: Add a dt binding for mediatek
 MT2701 soc
In-Reply-To: <20160104095511.GB1524@katana>
References: <1451888138-11471-1-git-send-email-liguo.zhang@mediatek.com>
 <20160104095511.GB1524@katana>
Message-ID: <1452215528.2088.0.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-01-04 at 10:55 +0100, Wolfram Sang wrote:
> On Mon, Jan 04, 2016 at 02:15:37PM +0800, Liguo Zhang wrote:
> > Add a dt binding for the MT2701 soc.
> > 
> > Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> 
> This should probably go with the other patch via arm-soc, or?

The patch about i2c dts info for MT2701 depends on the MT2701 clock
patch. After the MT2701 clock patch is accepted, the i2c patch for
MT2701 may be accepted.

The MT2701 clock patch:
http://lists.infradead.org/pipermail/linux-mediatek/2016-January/003489.html

> 
> In that case:
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> 
