From: balbi@ti.com (Felipe Balbi)
Date: Thu, 27 Jun 2013 11:40:04 +0300
Subject: [PATCH v3 1/5] phy: Add driver for Exynos MIPI CSIS/DSIM DPHYs
In-Reply-To: <51CBF9B8.70103@samsung.com>
References: <1372258946-15607-1-git-send-email-s.nawrocki@samsung.com>
 <1372258946-15607-2-git-send-email-s.nawrocki@samsung.com>
 <20130627075223.GQ15455@arwen.pp.htv.fi>
 <51CBF9B8.70103@samsung.com>
Message-ID: <20130627084004.GS15455@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 10:37:12AM +0200, Sylwester Nawrocki wrote:
> On 06/27/2013 09:52 AM, Felipe Balbi wrote:
> > On Wed, Jun 26, 2013 at 05:02:22PM +0200, Sylwester Nawrocki wrote:
> >> Add a PHY provider driver for the Samsung S5P/Exynos SoC MIPI CSI-2
> >> receiver and MIPI DSI transmitter DPHYs.
> >>
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > 
> > Acked-by: Felipe Balbi <balbi@ti.com>
> 
> Thank you for your review and ack!
> 
> Just for the record, I have tested this driver as a loadable
> module on Exynos4412 TRATS2 board and it all worked fine for
> both the camera and display side.

Awesome dude :-) very cool, let's hope more users convert to Kishon's
generic phy layer :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130627/a1037fd2/attachment.sig>
