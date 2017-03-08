From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Mar 2017 08:36:18 +0100
Subject: [PATCH 0/2] ARM: dts: sunxi: Remove no longer used
 pinctrl/sun4i-a10.h header
In-Reply-To: <20170308032821.26854-1-wens@csie.org>
References: <20170308032821.26854-1-wens@csie.org>
Message-ID: <20170308073618.kslqz3c2wdctexvi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 11:28:19AM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This series gets rid of the last usage of the Allwinner specific pinconf
> bindings, and drops inclusion of dt-bindings/pinctrl/sun4i-a10.h across
> the tree.
> 
> Patch 1 gets rid of the last occurrence of Allwinner specific pinconf
> properties, which is actually a GPIO pinmux.
> 
> Patch 2 drops the #include for dt-bindings/pinctrl/sun4i-a10.h with a
> scripted approach.
> 
> A patch to remove the actual header file should be sent after this
> series is in Linus' tree, to avoid any unwanted cross-tree dependencies.
> If we want that to happen faster, maybe we could merge these as fixes.
> 
> Regards
> ChenYu

Applied both, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170308/be7a28d3/attachment.sig>
