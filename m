From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 17 Dec 2017 19:05:55 +0100
Subject: [PATCH v1 4/4] arm64: dts: mediatek: add mt2712 cpufreq related
 device nodes
In-Reply-To: <a68c5382-2a9c-6c3c-ea67-99db46bdff1a@gmail.com>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <20171212072625.GL25177@vireshk-i7>
 <a68c5382-2a9c-6c3c-ea67-99db46bdff1a@gmail.com>
Message-ID: <7730089.t6jDuHQEn5@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 12, 2017 10:34:42 AM CET Matthias Brugger wrote:
> Hi,
> 
> On 12/12/2017 08:26 AM, Viresh Kumar wrote:
> > On 12-12-17, 02:17, Rafael J. Wysocki wrote:
> >> On Monday, December 11, 2017 8:57:19 AM CET Viresh Kumar wrote:
> >>> On 08-12-17, 14:07, Andrew-sh Cheng wrote:
> >>>> Add opp v2 information,
> >>>> and also add clocks, regulators and opp information into cpu nodes
> >>>>
> >>>> Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 27 ++++++++++++++
> >>>>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 57 +++++++++++++++++++++++++++++
> >>>>  2 files changed, 84 insertions(+)
> >>>
> >>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>
> >> Of course, DT bindings require ACKs from DT maintainers to be applied.
> > 
> > I didn't knew that we need Acks from DT maintainers for dts files as well? Yeah,
> > its very much required while defining new bindings for sure.
> > 
> 
> I will take the dts parts through the Mediatek SoC tree, so you don't have to
> worry about them.
> 
> Please let me know when you take patch 1 and 2.

Applied now, thanks!

Do you need the branch containing them to be exposed?

Thanks,
Rafael
