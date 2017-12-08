From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 08 Dec 2017 10:33:07 +0100
Subject: [PATCH v5 2/4] clk: meson-axg: add clocks dt-bindings required
 header
In-Reply-To: <20171207221014.6qwcb43w5hms4ma5@rob-hp-laptop>
References: <20171207095300.15384-1-yixun.lan@amlogic.com>
 <20171207095300.15384-3-yixun.lan@amlogic.com>
 <20171207221014.6qwcb43w5hms4ma5@rob-hp-laptop>
Message-ID: <1512725587.17256.19.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-07 at 16:10 -0600, Rob Herring wrote:
> On Thu, Dec 07, 2017 at 05:52:58PM +0800, Yixun Lan wrote:
> > From: Qiufang Dai <qiufang.dai@amlogic.com>
> > 
> > Add the required header for the clocks ID dt-bindings
> > exported from various subsystem in the Meson-AXG SoC.
> > 
> > Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > ---
> >  include/dt-bindings/clock/axg-clkc.h | 71
> > ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/axg-clkc.h
> 
> Please add acks when posting new versions.
> 
> Rob

Yixun, please be consistent about this. Maintainers are not going to dig
through your previous revision to collect Tags

I believe Neil acked patch 3, didn't he ?

Please resend your series with the Tags collected
If not already done, please make sure patches 1-3 apply on top of rc1 and patch
4 on Kevin's dt64 branch.

Thanks
Jerome
