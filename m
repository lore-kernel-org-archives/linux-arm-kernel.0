From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Wed, 16 Dec 2015 19:15:41 +0530
Subject: [PATCH V2 1/3] ARM: multi_v7_defconfig: Enable beaglebone PMIC
 TPS65217
In-Reply-To: <CAGo_u6pGcKoz_Vw9hWtuDJ8RBr+N4=G0p5RgEAcjheoe4VXhvQ@mail.gmail.com>
References: <1450118580-24754-1-git-send-email-nm@ti.com>
 <1450118580-24754-2-git-send-email-nm@ti.com>
 <20151215135100.GA8288@afzalpc>
 <CAGo_u6pGcKoz_Vw9hWtuDJ8RBr+N4=G0p5RgEAcjheoe4VXhvQ@mail.gmail.com>
Message-ID: <20151216134541.GA5574@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 15, 2015 at 08:49:07AM -0600, Nishanth Menon wrote:
> On Tue, Dec 15, 2015 at 7:51 AM, Afzal Mohammed <afzal.mohd.ma@gmail.com> wrote:
> > On Mon, Dec 14, 2015 at 12:42:58PM -0600, Nishanth Menon wrote:

> >> Enable PMIC for beaglebone similar to commit 7a5c6065669c ("ARM:
> >> OMAP2+: omap2plus_defconfig: Add tps65217 support") - this allows
> >> multi_v7_defconfig to boot up on older beaglebone platforms.
> >
> > A similar one -
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384289.html
> >
> > your v1 was earlier than the above, so mine should > /dev/null.
> 
> If you'd like to, please reply back on original patch dropping your
> patch.. or if queued, I can drop mine (I dont see it on linux-next
> yet).

That patch didn't get a reply at all, hence assuming that it won't be
picked & don't want to create a noise on that silent thread ;), but if
it gets applied, i will fight against my patch :)

> > Seems Arnd wants multi_v7_defconfig changes thr' submaintainers rather
> > than directly (which I initially thought was supposed to be done)
> 
> Just following what
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376637.html
> was told. I am ok as all the submaintainers should be in CC of this
> patch.

Hmm..,

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393016.html

but looks like Arnd applied it later.

> If you are ok with these patches, will appreciate to get a acked-by,
> if you dont mind.

Changelog refers to old beagle bone's, does new ones have a different
PMIC ?, i only have white bones ;)

Regards
afzal
