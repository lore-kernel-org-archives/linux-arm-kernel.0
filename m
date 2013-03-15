From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 15 Mar 2013 13:42:06 +0800
Subject: [PATCH 1/7] ARM: i.MX: Add GPT devicetree Documentation
In-Reply-To: <514210D2.6010605@wwwdotorg.org>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
 <1363262942-26702-2-git-send-email-s.hauer@pengutronix.de>
 <514210D2.6010605@wwwdotorg.org>
Message-ID: <20130315054203.GB31734@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 12:02:58PM -0600, Stephen Warren wrote:
> On 03/14/2013 06:08 AM, Sascha Hauer wrote:
> > The GPT binding is already used on i.MX6 and i.MX25, but not yet
> > documented. Add a binding document for it.
> 
> > diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> 
> > +Freescale i.MX GPT
> 
> You might want to mention what "GPT" is here, or at least expand the
> acronym. I first read this as "GUID Partition Table".

I just fixed it as below and applied the patch (actually the series).

Freescale i.MX General Purpose Timer (GPT)

Shawn
