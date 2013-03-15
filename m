From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Mar 2013 07:11:57 +0100
Subject: [PATCH 1/7] ARM: i.MX: Add GPT devicetree Documentation
In-Reply-To: <20130315054203.GB31734@S2101-09.ap.freescale.net>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
 <1363262942-26702-2-git-send-email-s.hauer@pengutronix.de>
 <514210D2.6010605@wwwdotorg.org>
 <20130315054203.GB31734@S2101-09.ap.freescale.net>
Message-ID: <20130315061157.GT1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 01:42:06PM +0800, Shawn Guo wrote:
> On Thu, Mar 14, 2013 at 12:02:58PM -0600, Stephen Warren wrote:
> > On 03/14/2013 06:08 AM, Sascha Hauer wrote:
> > > The GPT binding is already used on i.MX6 and i.MX25, but not yet
> > > documented. Add a binding document for it.
> > 
> > > diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> > 
> > > +Freescale i.MX GPT
> > 
> > You might want to mention what "GPT" is here, or at least expand the
> > acronym. I first read this as "GUID Partition Table".
> 
> I just fixed it as below and applied the patch (actually the series).
> 
> Freescale i.MX General Purpose Timer (GPT)

Thanks for fixing, Shawn.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
