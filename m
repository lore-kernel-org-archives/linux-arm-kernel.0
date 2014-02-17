From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Feb 2014 09:26:45 +0800
Subject: [PATCH v6] ARM: DTS: imx5* imx6*, use imx51-ssi
In-Reply-To: <20140216220827.GC31006@pengutronix.de>
References: <20140118083840.GD3430@S2101-09.ap.freescale.net>
 <1390220023-6423-1-git-send-email-mpa@pengutronix.de>
 <20140216220827.GC31006@pengutronix.de>
Message-ID: <20140217012643.GA9879@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 11:08:27PM +0100, Markus Pargmann wrote:
> Hi Shawn,
> 
> On Mon, Jan 20, 2014 at 01:13:43PM +0100, Markus Pargmann wrote:
> > imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
> > reconfiguration and needs this for correct interaction with SDMA. This
> > patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> > Hi Shawn,
> > 
> > Sorry for that last patch. I fixed it in this patch.
> 
> Ping. Should I send this again after rebasing it onto your latest branch?

I believe I've applied the v5 with a minor fix [1].  I split it into 2
though, one for imx5 [2] and the other for imx6 [2], because I have to
make my imx/dt pull request small to please arm-soc folks.

Shawn

[1] http://thread.gmane.org/gmane.linux.alsa.devel/117689/focus=117729
[2] http://git.linaro.org/people/shawn.guo/linux-2.6.git/commitdiff/28f93d0bbe171cf0c9051f22b550890740776bbb
[3] http://git.linaro.org/people/shawn.guo/linux-2.6.git/commitdiff/98ea6ad2edd21f953a43bd27182000a18a44dc20
