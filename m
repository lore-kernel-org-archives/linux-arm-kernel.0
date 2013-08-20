From: luka@openwrt.org (Luka Perkov)
Date: Tue, 20 Aug 2013 08:59:55 +0200
Subject: [PATCH] ARM: dts: imx6sl reuses imx6q sdma firmware
In-Reply-To: <20130820062555.GC29114@S2101-09.ap.freescale.net>
References: <1376903386-27771-1-git-send-email-shawn.guo@linaro.org>
 <20130819123541-7656@mutt-kz>
 <20130819135315.GA28297@S2101-09.ap.freescale.net>
 <20130819162827-27661@mutt-kz>
 <20130820062555.GC29114@S2101-09.ap.freescale.net>
Message-ID: <20130820065955-7214@mutt-kz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 02:25:58PM +0800, Shawn Guo wrote:
> > Naming it "sdma-imx6.bin" or "sdma-imx6x.bin"
> > would help avoiding confusions in the future (despite it's not SoC
> > name).
> 
> Just for example, if the next imx6 SoC uses a different sdma firmware,
> I guess "sdma-imx6.bin" or "sdma-imx6x.bin" would become the source
> of confusion.

Ok, agreed :)

Luka
