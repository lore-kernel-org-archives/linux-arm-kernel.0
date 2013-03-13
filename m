From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 14 Mar 2013 07:59:41 +1300
Subject: [PATCH 2/6] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <CACRpkdaE73mNUQ9Zg5+uwUROVFdDk7Uawnv=mWgYtvmdHtxD5Q@mail.gmail.com>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
 <CACRpkdZ14k_o-aO248NZJ6-jqxJf8AYhsZHLN_wPToyU1NsM6w@mail.gmail.com>
 <5140C4BF.3010708@wwwdotorg.org>
 <CACRpkdaE73mNUQ9Zg5+uwUROVFdDk7Uawnv=mWgYtvmdHtxD5Q@mail.gmail.com>
Message-ID: <1363201181.2452.0.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 19:52 +0100, Linus Walleij wrote:
> On Wed, Mar 13, 2013 at 7:26 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> > On 03/13/2013 10:11 AM, Linus Walleij wrote:
> 
> >> I think there is something very strange about this parsing code
> >> if you can't use the common accessors to get the stuff you want,
> >> if you really need to inspect properties like that static inline does,
> >> then it should be explained and the function should *not* be in
> >> this driver but a helper in <linux/of_*> somewhere.
> >
> > There is no of_property_read_u32_index(), which would read the nth u32
> > in a list of them. You're right there probably should be. My fault for
> > not creating one when I first wrote that code in the Tegra driver:-(
> 
> Hm OK so Tony,
> can we have a separate patch for adding that to the OF helpers,
> (to be ACKed by Rob).
> 
> I bet Stephen will quickly send a patch for fixing up the Tegra driver
> after that :-)
> 
> Yours,
> Linus Walleij

Will do.

Regards
Tony P
