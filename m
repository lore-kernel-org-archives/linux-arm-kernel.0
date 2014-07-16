From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 16 Jul 2014 10:27:59 +0200
Subject: [PATCH 4/4] ARM: dts: imx6qdl: Enable CODA960 VPU
In-Reply-To: <20140618151229.GR8860@dragon>
References: <1402679641-868-1-git-send-email-p.zabel@pengutronix.de>
 <1402679641-868-4-git-send-email-p.zabel@pengutronix.de>
 <20140618151229.GR8860@dragon>
Message-ID: <1405499279.3622.4.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 18.06.2014, 23:12 +0800 schrieb Shawn Guo:
> On Fri, Jun 13, 2014 at 07:14:01PM +0200, Philipp Zabel wrote:
> > This patch adds links to the on-chip SRAM and reset controller nodes
> > and switches the interrupts. Make the BIT processor interrupt, which exists on
> > all variants, the first one. The JPEG unit interrupt, which does not exist on
> > i.MX27 and i.MX5 thus is an optional second interrupt.
> > Use different compatible strings for i.MX6Q/D and i.MX6S/DL, as they have to
> > load separate firmware images for some reason.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> The whole series looks good to me.
> 
> Rob,
> 
> Do you want to apply the first patch through DT tree, or may I have your
> ACK to take the whole series via IMX tree?

Hi,

are there any reservations about these patches being merged through
Shawn's IMX tree?

regards
Philipp
