From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Apr 2018 11:29:47 +0200
Subject: [PATCH 10/61] gpio: simplify getting .drvdata
In-Reply-To: <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
 <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
Message-ID: <20180430092947.GC2270@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 11:03:25AM +0200, Linus Walleij wrote:
> On Thu, Apr 19, 2018 at 5:14 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> > On 04/19/2018 09:05 AM, Wolfram Sang wrote:
> >>
> >> We should get drvdata from struct device directly. Going via
> >> platform_device is an unneeded step back and forth.
> >>
> >> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> ---
> >>
> >> Build tested only. buildbot is happy. Please apply individually.
> >
> >
> > for gpio-omap.c:
> > Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Hm I only see the responses not the actual patch, I guess I will find it
> sooner or later.
> 
> Wolfram: if I don't find it, poke me with something sharp so I get to apply it.

I had the same problem, turned out this got classified as spam by Google
for some reason. Maybe try your spam folder?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180430/ea1ee48f/attachment-0001.sig>
