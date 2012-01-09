From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jan 2012 15:17:16 +0800
Subject: [PATCH 4/6] arm/dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <20120109064328.GS29065@opensource.wolfsonmicro.com>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-5-git-send-email-richard.zhao@linaro.org>
 <20120108145254.GE20216@S2101-09.ap.freescale.net>
 <20120108205504.GF29065@opensource.wolfsonmicro.com>
 <20120109005603.GA1835@S2101-09.ap.freescale.net>
 <4F0A613F.80509@gmail.com>
 <CAMPhdO9gaZQ0oQpfmvvL6MWP_6L9XCOdXYNSgjqDWLQ73XpRpw@mail.gmail.com>
 <20120109062511.GP29065@opensource.wolfsonmicro.com>
 <20120109065238.GK1835@S2101-09.ap.freescale.net>
 <20120109064328.GS29065@opensource.wolfsonmicro.com>
Message-ID: <20120109071714.GM1835@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 10:43:29PM -0800, Mark Brown wrote:
> On Mon, Jan 09, 2012 at 02:52:40PM +0800, Shawn Guo wrote:
> > On Sun, Jan 08, 2012 at 10:25:12PM -0800, Mark Brown wrote:
> 
> > > That would be non-idiomatic for the regulators - the idiom for the
> > > regulator API is to use upper case names as that's the idiom used to
> > > label supplies in datasheets and schematics.
> 
> > Hmm, the idiom seems not so strong.
> 
> > drivers/mmc/host/sdhci.c:
> 
> > 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
> 
> It's purely an idiom, there's nothing enforcing it.

Actually, a rough calculation on 'git grep regulator_get drivers/'
output tells 80% callers are using lower case.

-- 
Regards,
Shawn
