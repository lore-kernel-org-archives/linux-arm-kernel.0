From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Feb 2016 09:54:05 -0600
Subject: [PATCH 05/11] drivers: pinctrl: add driver for Allwinner A64 SoC
In-Reply-To: <20160204165151.GK4270@lukather>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-6-git-send-email-andre.przywara@arm.com>
 <20160201182754.GA14737@excalibur.cnev.de>
 <56AFE0EC.8080207@arm.com> <20160202100046.GM4652@lukather>
 <56B0DF26.10203@arm.com> <20160204165151.GK4270@lukather>
Message-ID: <20160208155405.GA4677@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 05:51:51PM +0100, Maxime Ripard wrote:
> Hi Andre,
> 
> On Tue, Feb 02, 2016 at 04:53:58PM +0000, Andre Przywara wrote:
> > > So, droping it in the filenames, why not. But I'd really like to keep
> > > the same compatible scheme.
> > 
> > And I still don't get this: in the DT compatible scheme we always have a
> > vendor prefix, so allwinner,a64 is surely not a mysterious ARM Ltd. core
> > or a new Apple SoC. Instead it is the A64 from Allwinner, full stop. So
> > why should we add an arbitrary and confusing sun50i naming to it (when
> > it actually should be more like "sun8i-a64").
> 
> I don't decide on their marketing names. And I know you want to start
> anew with the arm64 SoCs, but the truth is, you don't. Most of the
> compatibles in the DTSI are from earlier SoCs, and we have to keep
> that legacy and remain consistent with it. With all the good and bad
> things a legacy imply.

I have to agree. Unless there is some agreement to move to another 
naming scheme, then just follow the same pattern. If sunXi is just a 
made up name outside of Allwinner to provide some logical grouping of 
SoCs, then yes, that probably should not have been done.

Rob
