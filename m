From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Apr 2016 08:42:37 -0700
Subject: dtc warnings
In-Reply-To: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
Message-ID: <20160401154237.GK9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Rob Herring <robh@kernel.org> [160331 18:42]:
> You may have noticed that linux-next had gotten noisy with dtc
> warnings lately. I dropped the change for a bit, but added it back
> today except now it is disabled unless building with "W=1".
> 
> There's ~25K (2500 unique) warnings generated from the ARM dts files.
> Here's the ranking of warnings by dtb. OMAP is the clear winner (based
> on the similar counts, probably lots of duplicates). Please help
> remind contributors to test with W=1 and start to fix these.

I think Tero already has been looking at fixing the omap clock
related warnings that seem to produce most of these, so adding
him to Cc.

Regards,

Tony
