From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 8 Jan 2012 22:25:12 -0800
Subject: [PATCH 4/6] arm/dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <CAMPhdO9gaZQ0oQpfmvvL6MWP_6L9XCOdXYNSgjqDWLQ73XpRpw@mail.gmail.com>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-5-git-send-email-richard.zhao@linaro.org>
 <20120108145254.GE20216@S2101-09.ap.freescale.net>
 <20120108205504.GF29065@opensource.wolfsonmicro.com>
 <20120109005603.GA1835@S2101-09.ap.freescale.net>
 <4F0A613F.80509@gmail.com>
 <CAMPhdO9gaZQ0oQpfmvvL6MWP_6L9XCOdXYNSgjqDWLQ73XpRpw@mail.gmail.com>
Message-ID: <20120109062511.GP29065@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 01:05:39PM +0800, Eric Miao wrote:

> > If you want lower case names, then change the sgtl5000 code to lower
> > case names.

> +1, I'd vote for consistent lower case names.

That would be non-idiomatic for the regulators - the idiom for the
regulator API is to use upper case names as that's the idiom used to
label supplies in datasheets and schematics.
