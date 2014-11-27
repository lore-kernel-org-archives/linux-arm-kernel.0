From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 13:36:36 +0100
Subject: [PATCH 01/19] pinctrl: exynos: Add support for Exynos5433
In-Reply-To: <CA+Ln22FtvUD1HqH9PCGPCRu8Cyc6u4oNnsrEWyKYODtCT8wKHQ@mail.gmail.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <3904347.Bp2gmpYM49@wuerfel>
 <CA+Ln22FtvUD1HqH9PCGPCRu8Cyc6u4oNnsrEWyKYODtCT8wKHQ@mail.gmail.com>
Message-ID: <4132795.KBVIQFTevx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 21:14:59 Tomasz Figa wrote:
> > my impression is that with the
> > move to arm64, you should come up with a new binding that can fully
> > describe each controller so you don't have to add new code and bindings
> > for each future SoC that uses the same scheme.
> 
> Still, this is exactly the same thing I thought when initially refactoring this
> driver 2 years ago and what was dismissed at that time due to people
> supposedly not wanting that much data in DT. If this point of view has changed,
> then I fully support your view, though.

I guess people were at the time underestimating the rate at which Samsung
comes out with new SoC variants that are all slightly different.

	Arnd
