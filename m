From: luka@openwrt.org (Luka Perkov)
Date: Mon, 19 Aug 2013 18:28:27 +0200
Subject: [PATCH] ARM: dts: imx6sl reuses imx6q sdma firmware
In-Reply-To: <20130819135315.GA28297@S2101-09.ap.freescale.net>
References: <1376903386-27771-1-git-send-email-shawn.guo@linaro.org>
 <20130819123541-7656@mutt-kz>
 <20130819135315.GA28297@S2101-09.ap.freescale.net>
Message-ID: <20130819162827-27661@mutt-kz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 09:53:17PM +0800, Shawn Guo wrote:
> On Mon, Aug 19, 2013 at 02:35:42PM +0200, Luka Perkov wrote:
> > On Mon, Aug 19, 2013 at 05:09:46PM +0800, Shawn Guo wrote:
> > Also, last patch containing sdma firmware blobs sent to the mailing list
> > [1] uses "sdma-imx6.bin" name.
> 
> The patch never got merged.  I do not like the name, simply because imx6
> is not a SoC name.

IMHO "sdma-imx6.bin" is much more descriptive then "sdma-imx6q.bin" in
this case.

It could have been named "foobar" as far as I am concerned. But because
it was named "sdma-imx6q.bin" in imx6qdl.dtsi error was made when new
imx6sl.dtsi was created. Naming it "sdma-imx6.bin" or "sdma-imx6x.bin"
would help avoiding confusions in the future (despite it's not SoC
name).

Luka
