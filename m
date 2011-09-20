From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 20 Sep 2011 11:23:59 -0600
Subject: [PATCH V2 0/6] spi/spi-pl022 fixes
In-Reply-To: <4E78761C.9030908@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<4E5F58BB.4020205@st.com>
	<CACRpkdYeq9in+U_tyvb=yVuX2t5TnkUSsO+BozUGVJwZVh+4Ag@mail.gmail.com>
	<4E78761C.9030908@st.com>
Message-ID: <20110920172359.GB7781@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 04:46:44PM +0530, Viresh Kumar wrote:
> On 9/1/2011 4:26 PM, Linus Walleij wrote:
> > I agree. Acked-by: Linus Walleij <linus.walleij@linaro.org> for
> > all except 6/6, it's probably just as possible to keep the channel handle
> > taken in the driver if we modify the affected DMA driver instead.
> > This would be better for performance I think.
> 
> Hi Grant,
> 
> Any updates on this?

Applied 1-5, thanks.

g.

> 
> -- 
> viresh
