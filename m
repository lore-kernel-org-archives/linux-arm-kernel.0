From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 19 Apr 2018 10:25:41 -0700
Subject: [PATCH v1 2/4] dt-bindings: clock: mediatek: add g3dsys bindings
In-Reply-To: <1524109802.12959.10.camel@mtkswgap22>
References: <cover.1524044917.git.sean.wang@mediatek.com>
 <4b5d243d33433f83874359794b796d4228574714.1524044917.git.sean.wang@mediatek.com>
 <152410791532.46528.10083030894445315558@swboyd.mtv.corp.google.com>
 <1524109802.12959.10.camel@mtkswgap22>
Message-ID: <152415874117.46528.7501317526173019067@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sean Wang (2018-04-18 20:50:02)
> On Wed, 2018-04-18 at 20:18 -0700, Stephen Boyd wrote:
> > Quoting sean.wang at mediatek.com (2018-04-18 03:24:54)
> > > From: Sean Wang <sean.wang@mediatek.com>
> > > 
> > > Add bindings to g3dsys providing necessary clock and reset control to
> > > Mali-450.
> > > 
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > ---
> > >  .../bindings/arm/mediatek/mediatek,g3dsys.txt      | 30 ++++++++++++++++++++++
> > 
> > Why isn't this under bindings/clock/ ?
> > 
> 
> Tons of bindings for clock controller have been present at
> binding/arm/mediatek. g3dsys just have a follow-up to them.
> 
> It's worth another patch moving them all from bindings/arm/mediatek/ to
> bindings/clock/mediatek.
> 
> what's your opinion for either doing it prior to g3dsys binding being
> added or doing it in the future ?
> 

Doing it at a later time is fine. Just wondering why they're all getting
dumped into the arm/ directory.
