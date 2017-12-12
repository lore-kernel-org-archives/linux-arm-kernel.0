From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 12 Dec 2017 12:56:25 +0530
Subject: [PATCH v1 4/4] arm64: dts: mediatek: add mt2712 cpufreq related
 device nodes
In-Reply-To: <1758225.tOgn8eUOoH@aspire.rjw.lan>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1512713278-17807-5-git-send-email-andrew-sh.cheng@mediatek.com>
 <20171211075719.GD25177@vireshk-i7>
 <1758225.tOgn8eUOoH@aspire.rjw.lan>
Message-ID: <20171212072625.GL25177@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-12-17, 02:17, Rafael J. Wysocki wrote:
> On Monday, December 11, 2017 8:57:19 AM CET Viresh Kumar wrote:
> > On 08-12-17, 14:07, Andrew-sh Cheng wrote:
> > > Add opp v2 information,
> > > and also add clocks, regulators and opp information into cpu nodes
> > > 
> > > Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 27 ++++++++++++++
> > >  arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 57 +++++++++++++++++++++++++++++
> > >  2 files changed, 84 insertions(+)
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Of course, DT bindings require ACKs from DT maintainers to be applied.

I didn't knew that we need Acks from DT maintainers for dts files as well? Yeah,
its very much required while defining new bindings for sure.

-- 
viresh
