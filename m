From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 10:00:42 +0100
Subject: [PATCH v2 0/3] Allwinner H6 Ethernet support
In-Reply-To: <20181103123238.4665-1-icenowy@aosc.io>
References: <20181103123238.4665-1-icenowy@aosc.io>
Message-ID: <20181105090042.u5x2h6rek4nyaghc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2018 at 08:32:35PM +0800, Icenowy Zheng wrote:
> This patchset introduces Allwinner H6 Ethernet support with code already
> available for A64.
> 
> As the EMAC on H6 is similar to A64 ones, support for them are directly
> reused, by using fallback compatible strings.
> 
> Patches about system controller in v1 is sent by Jernej Skabrec as part
> of his H6 display patchset, and already gets applied.
> 
> NOTE: This patchset targets the final version of Pine H64, and also
> supports the early sample of Pine H64 model B. However, it's not
> compatible with the early sample of Pine H64 model A. Please DO NOT test
> this patchset on the Pine H64 model A samples.

Applied thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/15ddd993/attachment.sig>
