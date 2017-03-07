From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Mar 2017 18:07:51 +0100
Subject: [PATCH v8 0/6] Allwinner H5 and Orange Pi PC2 support
In-Reply-To: <20170306171750.7491-1-icenowy@aosc.xyz>
References: <20170306171750.7491-1-icenowy@aosc.xyz>
Message-ID: <20170307170751.n6tvrztet724pxfl@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 07, 2017 at 01:17:44AM +0800, Icenowy Zheng wrote:
> Allwinner H5 is a 64-bit SoC with a design like the 32-bit
> H3, and it's pin-to-pin compatible with H3.
> 
> This patchset adds support for it, along with the first available
> board -- Orange Pi PC2.
> 
> Several H5 boards by Sinovoip Banana Pi and FriendlyARM Nano Pi
> are coming, so we should get ready for them.
> 
> CCU changes are already said to be merged by Maxime Ripard, so
> this patchset now contains only device tree patches.
> 
> Commit messages are changed by the suggestion of Maxime.
> 
> This patchset depends on patchset [1] to finally take effect. At
> least the patch 1 of that patchset is needed if you want to test
> the kernel image -- without it the pinctrl driver won't be built
> and the kernel will become unusable without pinctrl.

It's still not the prefixes I told you to use. I merged your patches
and fixed, but please use the right one next time (and be consistent
in your ARM vs arm usage).

Thanks for your work!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170307/624c65b5/attachment.sig>
