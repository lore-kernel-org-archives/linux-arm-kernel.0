From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 04 Feb 2014 19:48:17 +0100
Subject: [PATCH v4] of: add functions to count number of elements in a
 property
In-Reply-To: <20140204173034.2D899C4050F@trevor.secretlab.ca>
References: <27256277.YJ687suYy5@phil>
 <CAL_JsqJord1OOjwcKk1jqF5o+XO3uw+Lc4ATtQacgwZWAoQq1g@mail.gmail.com>
 <20140204173034.2D899C4050F@trevor.secretlab.ca>
Message-ID: <13514940.URVnEJ4NF0@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Tuesday, 4. February 2014 17:30:34 Grant Likely wrote:
> On Sat, 18 Jan 2014 09:07:30 -0600, Rob Herring <robherring2@gmail.com> 
wrote:
> > On Sat, Jan 18, 2014 at 6:02 AM, Heiko St??bner <heiko@sntech.de> wrote:
> > > The need to know the number of array elements in a property is
> > > a common pattern. To prevent duplication of open-coded implementations
> > > add a helper static function that also centralises strict sanity
> > > checking and DTB format details, as well as a set of wrapper functions
> > > for u8, u16, u32 and u64.
> > > 
> > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > 
> > Looks good. Do you plan to convert some users to use this?
> 
> I'll take that as an acked-by. Merged, thanks.

before you taking this patch, I was planning on simply sending this as part of 
my rockchip-smp series - as I'm currently the only user of it :-) .

This going through your tree is most likely the better way, but now I need it 
to somehow make its way into arm-soc too ... I guess some sort of stable 
branch arm-soc could pull?


Thanks
Heiko
