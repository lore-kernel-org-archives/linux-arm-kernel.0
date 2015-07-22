From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 22 Jul 2015 22:05:00 +0800
Subject: [PATCH 0/6] mmc: sdhci-esdhci-imx: fix cd/wp regression
In-Reply-To: <CAPDyKFruDiS=DV=AjiaGWvDxFN_Zj5Hp0LifROxCUpCySAeQpA@mail.gmail.com>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
 <20150709075032.GD23464@tiger>
 <20150709092949.GB3917@shlinux1.ap.freescale.net>
 <20150709132736.GG23464@tiger>
 <20150713114310.GA9453@shlinux1.ap.freescale.net>
 <CAPDyKFruDiS=DV=AjiaGWvDxFN_Zj5Hp0LifROxCUpCySAeQpA@mail.gmail.com>
Message-ID: <20150722140459.GB13623@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 02:44:07PM +0200, Ulf Hansson wrote:
> On 13 July 2015 at 13:43, Dong Aisheng <b29396@freescale.com> wrote:
> > On Thu, Jul 09, 2015 at 09:27:36PM +0800, Shawn Guo wrote:
> >> On Thu, Jul 09, 2015 at 05:29:50PM +0800, Dong Aisheng wrote:
> >> > I agree with you.
> >> > One difference is that i'd like to fix it ASAP without reverting 8d86e4f
> >> > due to more patches depends on it is already there as i mentioned above..
> >> > Revert it may need to revert a lot others.
> >> >
> >> > The pain is that v4.1 is left broken.
> >>
> >> Oh, crap!  I thought it's been there with only v4.2-rc1, and did not
> >> know v4.1 is already broken.  In that case, reverting 8d86e4f isn't
> >> the best option.  I suggest you rebase the dts series on top of
> >> v4.2-rc1, and send it via mmc tree.
> >>
> >
> > Yes, will go that way.
> >
> > Then you may need help take care of new dts going through your tree
> > to make sure no broken code in again.
> 
> Dong, Shawn,
> 
> I am happy to help out, I assume you want this to go as fixes for 4.2rc[n].
> 
> Correct me if I am wrong, you want me to apply the DTS patches prior
> the MMC patches. I tried applying the DTS patches on 4.2rc3 - it still
> works nicely so no re-base is needed.
> 
> 
> So, then I need an ack from Shawn for the DTS series...
> 

Hi Ulf,

I have merged the two seris into one (dts changes is before controller changes)
and rebase based on your ulf/next branch.
The updated patch series is just sent out for review.

Shawn,
Please help review and ACK for Ulf to apply.

Regards
Dong Aisheng

> Kind regards
> Uffe
