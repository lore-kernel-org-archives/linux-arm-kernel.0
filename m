From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 11:31:52 -0800
Subject: [PATCH V2 1/3] ARM: multi_v7_defconfig: Enable beaglebone PMIC
 TPS65217
In-Reply-To: <20151216134541.GA5574@afzalpc>
References: <1450118580-24754-1-git-send-email-nm@ti.com>
 <1450118580-24754-2-git-send-email-nm@ti.com>
 <20151215135100.GA8288@afzalpc>
 <CAGo_u6pGcKoz_Vw9hWtuDJ8RBr+N4=G0p5RgEAcjheoe4VXhvQ@mail.gmail.com>
 <20151216134541.GA5574@afzalpc>
Message-ID: <20151222193152.GW30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 07:15:41PM +0530, Afzal Mohammed wrote:
> Hi,
> 
> On Tue, Dec 15, 2015 at 08:49:07AM -0600, Nishanth Menon wrote:
> > On Tue, Dec 15, 2015 at 7:51 AM, Afzal Mohammed <afzal.mohd.ma@gmail.com> wrote:
> > > On Mon, Dec 14, 2015 at 12:42:58PM -0600, Nishanth Menon wrote:
> 
> > >> Enable PMIC for beaglebone similar to commit 7a5c6065669c ("ARM:
> > >> OMAP2+: omap2plus_defconfig: Add tps65217 support") - this allows
> > >> multi_v7_defconfig to boot up on older beaglebone platforms.
> > >
> > > A similar one -
> > >
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384289.html
> > >
> > > your v1 was earlier than the above, so mine should > /dev/null.
> > 
> > If you'd like to, please reply back on original patch dropping your
> > patch.. or if queued, I can drop mine (I dont see it on linux-next
> > yet).
> 
> That patch didn't get a reply at all, hence assuming that it won't be
> picked & don't want to create a noise on that silent thread ;), but if
> it gets applied, i will fight against my patch :)

As mentioned in the earlier reply, don't assume a patch that hasn't been
applied yet won't be -- please follow up with a redaction of it if that's what
you want. Since I go through my mail folder in chronological order, I come
across your patch first and will apply it when I get to it.

Anyway, not a big deal since the contents is the same.



-Olof
