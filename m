From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Aug 2017 14:05:17 -0700
Subject: [PATCH 12/15] arm-soc: omap: replace open coded VA->PA
 calculations
In-Reply-To: <CAKv+Gu-kdjN8nXVNL2frsegu-z7HVnG8qcXpQbvM-oBbxKjUGA@mail.gmail.com>
References: <20170805205222.19868-1-ard.biesheuvel@linaro.org>
 <20170805205222.19868-13-ard.biesheuvel@linaro.org>
 <20170809190556.GD3934@atomide.com>
 <CAKv+Gu-kdjN8nXVNL2frsegu-z7HVnG8qcXpQbvM-oBbxKjUGA@mail.gmail.com>
Message-ID: <20170809210517.GE3934@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ard Biesheuvel <ard.biesheuvel@linaro.org> [170809 12:24]:
> On 9 August 2017 at 20:05, Tony Lindgren <tony@atomide.com> wrote:
> > * Ard Biesheuvel <ard.biesheuvel@linaro.org> [170805 13:54]:
> >> This replaces a couple of open coded calculations to obtain the
> >> physical address of a far symbol with calls to the new adr_l etc
> >> macros.
> >
> > I gave this series a quick test and omap3 no longer boots it seems.
> >
> 
> Thanks Tony. I will investigate

Thanks. Looks like omap4 still boots with all your patches, but
omap3 won't boot even with patch 12 left out.

Regards,

Tony
