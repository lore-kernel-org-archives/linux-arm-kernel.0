From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Dec 2011 10:53:46 +0000
Subject: [PATCH v4 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111227015109.GJ15863@b20223-02.ap.freescale.net>
References: <20111223131851.GB13175@sirena.org.uk>
 <20111224085539.GA1892@richard-laptop>
 <20111224122411.GA13778@sirena.org.uk>
 <20111224132831.GB1803@richard-laptop>
 <20111224134227.GA20908@opensource.wolfsonmicro.com>
 <20111224155227.GC1803@richard-laptop>
 <20111226111030.GC8722@opensource.wolfsonmicro.com>
 <20111226134449.GA4259@richard-laptop>
 <20111226142234.GH8722@opensource.wolfsonmicro.com>
 <20111227015109.GJ15863@b20223-02.ap.freescale.net>
Message-ID: <20111227105345.GF2870@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2011 at 09:51:10AM +0800, Richard Zhao wrote:
> On Mon, Dec 26, 2011 at 02:22:34PM +0000, Mark Brown wrote:

> > Fix your mailer to word wrap properly please.

> If you mean last mail I sent, I didn't see anything wrong. I use
> mutt.

It's wrapping at a bit more than 80 columns a lot of the time.

> > > So what's your suggestion? We can not set transition_latency to set
> > > random number.

> > As I've repeatedly said I think you should define it to be the latency
> > for the SoC only, not for the regulators.

> Sometimes, regulators are in SoC too. To avoid confusion, I'll use below:
> clk-trans-latency = <61036>;

Makes sense.
