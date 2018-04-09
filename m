From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 9 Apr 2018 19:48:49 +0800
Subject: [PATCH V3] ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM
 and PDK2
In-Reply-To: <e860af85-0e80-5dea-8783-5cbab43d9fc8@denx.de>
References: <20180318173403.31460-1-marex@denx.de>
 <CAOMZO5BHyVf2N8q7oKpe3XEYAT77yR7WYWFeuofQihkP6+moUA@mail.gmail.com>
 <f22b8d2a-c8e4-94ab-3b87-9758c02ca63a@denx.de>
 <e860af85-0e80-5dea-8783-5cbab43d9fc8@denx.de>
Message-ID: <20180409114847.GC14582@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 08, 2018 at 06:40:04PM +0200, Marek Vasut wrote:
> On 03/27/2018 09:32 PM, Marek Vasut wrote:
> > On 03/20/2018 04:36 PM, Fabio Estevam wrote:
> >> On Sun, Mar 18, 2018 at 2:34 PM, Marek Vasut <marex@denx.de> wrote:
> >>> Add support for the DH i.MX6 Quad based SoM and a PDK2 evaluation board.
> >>> The evaluation board features three serial ports, USB OTG, USB host with
> >>> an USB hub, Fast or Gigabit ethernet, eMMC, uSD, SD, mSATA, analog audio,
> >>> PCIe and HDMI video output.
> >>>
> >>> All of the aforementioned features are supported by this patch.
> >>>
> >>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> >>> Cc: Shawn Guo <shawnguo@kernel.org>
> >>
> >> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> > 
> > Shawn, any response to this ?
> 
> Another two weeks have passed and still zero feedback.
> 
> I was complaining about getting no feedback on patches from you for long
> periods of time before, and that it is extremely demotivating for a
> contributor. It seems the situation has not improved at all.

This version looks good to me.  But please be aware of that we are in the
middle of 4.17 merge window, and my tree is kinda frozen until 4.17-rc1
is available.

Shawn
