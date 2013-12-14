From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 14 Dec 2013 09:15:07 +0400
Subject: [PATCH 1/3] can: mcp251x: Convert driver to use common clk
 framework
In-Reply-To: <528340A7.9080708@pengutronix.de>
References: <1384332144-15211-1-git-send-email-shc_work@mail.ru>
 <528340A7.9080708@pengutronix.de>
Message-ID: <20131214091507.35557bcf132c885cfba69008@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Nov 2013 10:04:39 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> as this series adds device tree bindings, please add
> devicetree at vger.kernel.org on Cc for the whole series.
> 
> On 11/13/2013 09:42 AM, Alexander Shiyan wrote:
> > This patch converts mcp251x driver to using common clk framework
> > for getting input frequency. The change was made for the preparation
> > of the driver work with the devicetree. As a result private header
> > for the driver is eliminated.
> > Additionally, all existing users of the driver was converted to use
> > this feature.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Looks good from my point of view. I'll take the whole series via the
> linux-can tree, if there are no objections. I'd like to have the pxa and
> imx maintainer's Ack and an Ack from the DT list.
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Ping. Resend?

-- 
Alexander Shiyan <shc_work@mail.ru>
