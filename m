From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Mar 2018 07:22:34 -0700
Subject: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
In-Reply-To: <CACRpkdanFFwPBhkDNRTdns9cPebH3drBZNhqZLBzF78U3XdRgw@mail.gmail.com>
References: <1519077427-30165-1-git-send-email-david@lechnology.com>
 <CACRpkdanFFwPBhkDNRTdns9cPebH3drBZNhqZLBzF78U3XdRgw@mail.gmail.com>
Message-ID: <20180323142234.GH5799@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [180323 03:02]:
> On Mon, Feb 19, 2018 at 10:57 PM, David Lechner <david@lechnology.com> wrote:
> 
> > This fixes pcs_request_gpio() in the pinctrl-single driver when
> > bits_per_mux != 0. It appears this was overlooked when the multiple
> > pins per register feature was added.
> >
> > Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
> > Signed-off-by: David Lechner <david@lechnology.com>
> > ---
> >
> > v2 changes:
> > - don't wrap Fixes: line in commit message since it is a special machine-
> >   readable line.
> 
> Tony/Haojian: are you OK with this change?

No objections from me, would be good if Haojian could
test it with his test cases though.

Regards,

Tony
