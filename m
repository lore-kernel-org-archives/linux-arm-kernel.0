From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Jan 2016 11:11:21 +0100
Subject: [linux-sunxi] Re: [PATCH 4/5] ARM: dts: sun5i: Add dts file for
 the Empire Electronix D709 tablet
In-Reply-To: <CAGb2v67+XpYwUFAVSGEGAfJ0bzubQ87Ebaf5W5Ze619mEE6uUA@mail.gmail.com>
References: <1450611782-9494-1-git-send-email-hdegoede@redhat.com>
 <1450611782-9494-4-git-send-email-hdegoede@redhat.com>
 <CAGb2v65daCCOWf7EXDkNWnxv1idXHXesOp6Et_0h-o+9drdeMA@mail.gmail.com>
 <5677D87A.90805@redhat.com> <20151221161132.GA30359@lukather>
 <567854D5.7030601@redhat.com>
 <CAGb2v67+XpYwUFAVSGEGAfJ0bzubQ87Ebaf5W5Ze619mEE6uUA@mail.gmail.com>
Message-ID: <20160104101121.GC11722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 22, 2015 at 12:29:24PM +0800, Chen-Yu Tsai wrote:
> >>> So this means enabled the sdio controller (should be safe on all
> >>> boards?)  and enabling 2 regulators to power the wifi-chip. I
> >>> think it will be safe to do this even on boards where those
> >>> regulators are not used, what do you think ?
> >>
> >> Wouldn't that introduce some useless power drain on those boards?
> >
> >
> > If nothing is attached to those regulators (which I expect to be
> > the case when they are not used to power wifi) then I would expect
> > the drain to be minimal, my biggest worry is some board having
> > tied these to ground, but I don't think that is very likely.
> 
> AFAIK the AXP datasheets mention that unused DCDC outputs should be left
> floating. Not sure if this applies to LDO outputs as well. But any used
> outputs would have a bypass capacitor.
> 
> From the board designs I've seen, this seems to be the common case.
> I'm not an electrical engineer, but I think we're covered here.

Ok, I guess we're good then.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/222f1583/attachment-0001.sig>
