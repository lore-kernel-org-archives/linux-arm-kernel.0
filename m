From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue, 17 Jul 2018 16:53:41 +0200
Subject: [PATCH 1/3] ARM: dts: imx53-ppd: Enable secure-reg-access
In-Reply-To: <20180717055149.GE4576@dragon>
References: <1531400558-20700-1-git-send-email-fabio.estevam@nxp.com>
 <20180717055149.GE4576@dragon>
Message-ID: <20180717145341.cxo4xxznvserq5ks@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 17, 2018 at 01:51:50PM +0800, Shawn Guo wrote:
> On Thu, Jul 12, 2018 at 10:02:36AM -0300, Fabio Estevam wrote:
> > From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > 
> > Add 'secure-reg-access' property to enable PMU and hardware counters
> > so that they can be properly used with the 'perf' tool.
> > 
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > [fabio: kept the change only in imx53-ppd context]
> > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Applied all, thanks.

Thanks,

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/15c12c30/attachment.sig>
