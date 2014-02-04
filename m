From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 04 Feb 2014 17:30:34 +0000
Subject: [PATCH v4] of: add functions to count number of elements in a
 property
In-Reply-To: <CAL_JsqJord1OOjwcKk1jqF5o+XO3uw+Lc4ATtQacgwZWAoQq1g@mail.gmail.com>
References: <27256277.YJ687suYy5@phil> <1434798.oSb68sYmYT@phil> <
 CAL_JsqJ_St=OegpexzrTGXwmOYCz4YeWk_1S+R_q6NajmmPqSA@mail.gmail.com> <
 5115255.DrcMbtXc1P@phil> <
 CAL_JsqJord1OOjwcKk1jqF5o+XO3uw+Lc4ATtQacgwZWAoQq1g@mail.gmail.com>
Message-ID: <20140204173034.2D899C4050F@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 Jan 2014 09:07:30 -0600, Rob Herring <robherring2@gmail.com> wrote:
> On Sat, Jan 18, 2014 at 6:02 AM, Heiko St??bner <heiko@sntech.de> wrote:
> > The need to know the number of array elements in a property is
> > a common pattern. To prevent duplication of open-coded implementations
> > add a helper static function that also centralises strict sanity
> > checking and DTB format details, as well as a set of wrapper functions
> > for u8, u16, u32 and u64.
> >
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> 
> Looks good. Do you plan to convert some users to use this?

I'll take that as an acked-by. Merged, thanks.

g.
