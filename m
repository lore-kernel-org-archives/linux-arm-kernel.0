From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 11 Jan 2012 08:57:54 +0800
Subject: [PATCH 4/6] arm/dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <20120109071255.GB22134@opensource.wolfsonmicro.com>
References: <20120108145254.GE20216@S2101-09.ap.freescale.net>
 <20120108205504.GF29065@opensource.wolfsonmicro.com>
 <20120109005603.GA1835@S2101-09.ap.freescale.net>
 <4F0A613F.80509@gmail.com>
 <CAMPhdO9gaZQ0oQpfmvvL6MWP_6L9XCOdXYNSgjqDWLQ73XpRpw@mail.gmail.com>
 <20120109062511.GP29065@opensource.wolfsonmicro.com>
 <20120109065238.GK1835@S2101-09.ap.freescale.net>
 <20120109064328.GS29065@opensource.wolfsonmicro.com>
 <20120109071714.GM1835@S2101-09.ap.freescale.net>
 <20120109071255.GB22134@opensource.wolfsonmicro.com>
Message-ID: <20120111005753.GC2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 11:12:56PM -0800, Mark Brown wrote:
> On Mon, Jan 09, 2012 at 03:17:16PM +0800, Shawn Guo wrote:
> > On Sun, Jan 08, 2012 at 10:43:29PM -0800, Mark Brown wrote:
> 
> > > It's purely an idiom, there's nothing enforcing it.
> 
> > Actually, a rough calculation on 'git grep regulator_get drivers/'
> > output tells 80% callers are using lower case.
> 
> Add in the ASoC stuff (which I actually actively review) and I suspect
> the number changes.  Anyway, there is a good solid reason for wanting
> capitals in the code so...
Shawn and Mark,

Could you get agreement on it?
I incline to not forcing upper case property names.

Thanks
Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
