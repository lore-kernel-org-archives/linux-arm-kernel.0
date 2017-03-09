From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Mar 2017 11:53:58 +0100
Subject: [PATCH v8 0/6] Allwinner H5 and Orange Pi PC2 support
In-Reply-To: <2704251488908203@web18o.yandex.ru>
References: <20170306171750.7491-1-icenowy@aosc.xyz>
 <20170307170751.n6tvrztet724pxfl@lukather>
 <2704251488908203@web18o.yandex.ru>
Message-ID: <20170309105358.jmbzlenu3tcljrlc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 01:36:43AM +0800, Icenowy Zheng wrote:
> 
> 
> 08.03.2017, 01:07, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > Hi,
> >
> > On Tue, Mar 07, 2017 at 01:17:44AM +0800, Icenowy Zheng wrote:
> >> ?Allwinner H5 is a 64-bit SoC with a design like the 32-bit
> >> ?H3, and it's pin-to-pin compatible with H3.
> >>
> >> ?This patchset adds support for it, along with the first available
> >> ?board -- Orange Pi PC2.
> >>
> >> ?Several H5 boards by Sinovoip Banana Pi and FriendlyARM Nano Pi
> >> ?are coming, so we should get ready for them.
> >>
> >> ?CCU changes are already said to be merged by Maxime Ripard, so
> >> ?this patchset now contains only device tree patches.
> >>
> >> ?Commit messages are changed by the suggestion of Maxime.
> >>
> >> ?This patchset depends on patchset [1] to finally take effect. At
> >> ?least the patch 1 of that patchset is needed if you want to test
> >> ?the kernel image -- without it the pinctrl driver won't be built
> >> ?and the kernel will become unusable without pinctrl.
> >
> > It's still not the prefixes I told you to use. I merged your patches
> > and fixed, but please use the right one next time (and be consistent
> > in your ARM vs arm usage).
> 
> oh I added dts: to the prefix you told me, as they're device tree patches.
> 
> Is the usage of "dts:" out-dated?

I'd like to at least have a common scheme across regular contributors,
and not the current mess that we have. So, yes, kind of. And it
doesn't make much sense these days where all our changes are either
drivers or dts.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170309/3314fce4/attachment-0001.sig>
