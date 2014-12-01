From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 1 Dec 2014 14:56:24 -0800
Subject: [PATCH] ARM: zynq: DT: Add USB to device tree
In-Reply-To: <fb6f17c51aef4a498eb2a3e01a81df34@BN1BFFO11FD017.protection.gbl>
References: <1417459352-23401-1-git-send-email-soren.brinkmann@xilinx.com>
 <547CCEE3.6020806@suse.de>
 <fb6f17c51aef4a498eb2a3e01a81df34@BN1BFFO11FD017.protection.gbl>
Message-ID: <e016ae7c103a4fbd844826c9e25fe9c2@BY2FFO11FD036.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-12-01 at 01:24PM -0800, S?ren Brinkmann wrote:
> On Mon, 2014-12-01 at 09:26PM +0100, Andreas F?rber wrote:
> > Hi S?ren,
> > 
> > Am 01.12.2014 um 19:42 schrieb Soren Brinkmann:
> > > Add USB nodes to zc702, zc706 and zed device trees.
> > > 
> > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > ---
> > >  arch/arm/boot/dts/zynq-7000.dtsi | 22 +++++++++++++++++++++-
> > >  arch/arm/boot/dts/zynq-zc702.dts | 11 +++++++++++
> > >  arch/arm/boot/dts/zynq-zc706.dts | 10 ++++++++++
> > >  arch/arm/boot/dts/zynq-zed.dts   | 10 ++++++++++
> > >  4 files changed, 52 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> > > index ce2ef5bec4f2..9ed60938f301 100644
> > > --- a/arch/arm/boot/dts/zynq-7000.dtsi
> > > +++ b/arch/arm/boot/dts/zynq-7000.dtsi
[...]
> > > @@ -324,6 +344,6 @@
> > >  			reg = <0xf8005000 0x1000>;
> > >  			reset = <0>;
> > >  			timeout-sec = <10>;
> > > -		};
> > > +		} ;
> > >  	};
> > >  };
> > 
> > Unrelated accidental change here though. :)

Since a v2 is needed now, does this really require a dedicated patch to
fix this bogus space here or do we just look the other way?

	Thanks,
	S?ren
