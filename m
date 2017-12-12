From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 12 Dec 2017 02:17:06 +0100
Subject: [PATCH v1 4/4] arm64: dts: mediatek: add mt2712 cpufreq related
 device nodes
In-Reply-To: <20171211075719.GD25177@vireshk-i7>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1512713278-17807-5-git-send-email-andrew-sh.cheng@mediatek.com>
 <20171211075719.GD25177@vireshk-i7>
Message-ID: <1758225.tOgn8eUOoH@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 11, 2017 8:57:19 AM CET Viresh Kumar wrote:
> On 08-12-17, 14:07, Andrew-sh Cheng wrote:
> > Add opp v2 information,
> > and also add clocks, regulators and opp information into cpu nodes
> > 
> > Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 27 ++++++++++++++
> >  arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 57 +++++++++++++++++++++++++++++
> >  2 files changed, 84 insertions(+)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Of course, DT bindings require ACKs from DT maintainers to be applied.
